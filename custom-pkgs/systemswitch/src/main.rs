use clap::{Command, CommandFactory, Parser};
use clap_complete::{generate, Generator, Shell};
use colored::Colorize;
use notify_rust::{Image, Notification};
use std::{io, path::Path, sync::OnceLock, time::Duration};
use xshell::cmd;

const MAX_GH_RUN_LIST_ATTEMPS: i32 = 20;
const CONFIG_PATH: &str = "/etc/nixos";
const GH_REPO_OWNER: &str = "eldolfin";
const GH_REPO_NAME: &str = "nixos-config";
const CI_WORKFLOW_PATH: &str = "ci.yml";

#[derive(Clone, Parser, Debug, PartialEq)]
#[command(name = "systemswitch")]
/// A helper script to edit my nixos config files. Edit, commit, build and push
struct Opt {
    #[arg(long, short = 'n')]
    /// Do not execute anything, only print out the commands that would be run otherwise
    dry_run: bool,
    #[arg(long)]
    /// `git commit --amend`
    amend: bool,
    #[arg(long, short)]
    /// Only build, do not edit or commit
    build: bool,
    #[arg(long, short = 'u')]
    /// `git pull` first
    pull: bool,
    #[arg(long)]
    /// Do not run git commit
    no_commit: bool,
    #[arg(long)]
    /// Do not run git push
    no_push: bool,
    #[arg(long)]
    /// Do not build and switch to the new configuration
    no_build: bool,
    #[arg(long)]
    /// Do not open helix, for when the modifications are already made
    no_edit: bool,
    #[arg(long, short)]
    /// Use lazygit to add and commit
    lazy: bool,
    #[arg(long)]
    /// Update flake first
    upgrade: bool,
    #[arg(long)]
    /// `git push --force-with-lease`
    force: bool,
    #[arg(long, short)]
    /// Message to use in the commit
    message: Option<String>,
    #[arg(trailing_var_arg = true)]
    /// Arguments to pass to the editor
    rest: Vec<String>,
    // If provided, outputs the completion file for given shell
    #[arg(long = "generate-completions", value_enum)]
    generator: Option<Shell>,
}

fn print_completions<G: Generator>(gen: G, mut cmd: Command) {
    cmd = cmd.mut_args(|mut arg| {
        if arg.is_trailing_var_arg_set() {
            arg = arg.value_parser([CONFIG_PATH]);
        }
        arg
    });
    let bin_name = cmd.get_name().to_string();
    generate(gen, &mut cmd, bin_name, &mut io::stdout());
}

fn opt() -> &'static Opt {
    static OPT: OnceLock<Opt> = OnceLock::new();
    OPT.get_or_init(Opt::parse)
}

trait MaybeDryRun {
    fn maybe_dry_run(self) -> xshell::Result<()>;
}

impl MaybeDryRun for xshell::Cmd<'_> {
    fn maybe_dry_run(self) -> xshell::Result<()> {
        print_cmd(&self.to_string());
        if !opt().dry_run {
            self.quiet().run()
        } else {
            Ok(())
        }
    }
}

trait MaybeChangeDir {
    fn maybe_change_dir(&self, dir: impl AsRef<Path>);
}

impl MaybeChangeDir for xshell::Shell {
    fn maybe_change_dir(&self, dir: impl AsRef<Path>) {
        let cmd = format!("cd {}", dir.as_ref().display());
        print_cmd(&cmd);
        // run it regardless of dry_run. Shouldn't change anything right now
        self.change_dir(dir);
    }
}

fn print_cmd(cmd: &str) {
    let cmd = if opt().dry_run {
        cmd.dimmed()
    } else {
        cmd.normal()
    };
    eprintln!("{} {}", "❯".green(), cmd);
}

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    if let Some(generator) = opt().generator {
        let cmd = Opt::command();
        eprintln!("Generating completion file for {generator:?}...");
        print_completions(generator, cmd);
        return Ok(());
    }

    let sh = xshell::Shell::new()?;

    sh.maybe_change_dir(CONFIG_PATH);

    if opt().pull {
        cmd!(sh, "git pull").maybe_dry_run()?;
    }

    if opt().upgrade {
        cmd!(sh, "nix flake update").maybe_dry_run()?;
    }

    if !opt().build && !opt().upgrade && !opt().no_edit {
        let rest = opt().rest.clone();
        let editor = std::env::var("EDITOR").unwrap();
        let editor = Path::new(&editor);
        if rest.is_empty() {
            cmd!(sh, "{editor} .").maybe_dry_run()?;
        } else {
            cmd!(sh, "{editor} {rest...}").maybe_dry_run()?;
        }
    }
    if !opt().build && !opt().no_commit {
        if opt().lazy {
            cmd!(sh, "lazygit").maybe_dry_run()?;
        } else {
            let git_commit_args = git_commit_args();
            cmd!(sh, "git add .").maybe_dry_run()?;
            if cmd!(sh, "git diff --staged").maybe_dry_run().is_err() {
                eprintln!("No files changed!");
                return Ok(());
            }
            let res = if git_commit_args.is_empty() {
                cmd!(sh, "ai-commit.sh").maybe_dry_run().or_else(|_err| {
                    eprint!(
                        "{}",
                        "ai commit failed, falling back to normal git commit"
                            .red()
                            .bold()
                    );

                    cmd!(sh, "git commit").maybe_dry_run()
                })
            } else {
                cmd!(sh, "git commit {git_commit_args...}").maybe_dry_run()
            };
            if res.is_err() {
                eprint!(
                    "{}",
                    "An error occured while running `git commit`. Press enter to open lazygit"
                        .red()
                        .bold()
                );
                let read = std::io::stdin().read_line(&mut String::new()).unwrap();
                if read == 0 {
                    println!("\nExitting.");
                    return Ok(());
                }
                cmd!(sh, "lazygit").maybe_dry_run()?;
            }
        }
    }
    if !opt().no_build {
        cmd!(sh, "nh os switch {CONFIG_PATH}").maybe_dry_run()?;
        if !opt().dry_run {
            show_notification(&sh)?;
        }
    }

    if !opt().build && !opt().no_commit && !opt().no_push {
        let git_push_args = (opt().force || opt().amend).then_some("--force-with-lease");
        cmd!(sh, "git push {git_push_args...}").maybe_dry_run()?;
        // print_cmd("watch_github_action()");
        // if !opt().dry_run {
        //     watch_github_action(&sh).await?;
        // }
    }
    Ok(())
}

async fn watch_github_action(sh: &xshell::Shell) -> anyhow::Result<()> {
    let head_sha = cmd!(sh, "git rev-parse HEAD").output()?.stdout;
    let head_sha = String::from_utf8(head_sha).unwrap().trim().to_owned();

    let octo = octocrab::instance();
    let api = octo.workflows(GH_REPO_OWNER, GH_REPO_NAME);
    let mut run = None;
    for _ in 0..MAX_GH_RUN_LIST_ATTEMPS {
        tokio::time::sleep(Duration::from_secs(1)).await;
        let runs = api
            .list_runs(CI_WORKFLOW_PATH)
            .per_page(2)
            .status("in_progress")
            .event("push")
            .send()
            .await
            .inspect_err(|err| {
                dbg!(err);
            })?;
        if let Some(found) = runs.items.into_iter().find(|run| run.head_sha == head_sha) {
            run = Some(found);
            break;
        }
    }
    if let Some(run) = run {
        // TODO: maybe render graph here instead of using gh cli
        let run_id = run.id.to_string();
        cmd!(sh, "gh run watch {run_id}").maybe_dry_run()?;
    } else {
        eprintln!("Giving up on watching the github workflow");
    }
    Ok(())
}

fn show_notification(sh: &xshell::Shell) -> Result<(), anyhow::Error> {
    Notification::new()
        .summary("Systemswitch Switched!")
        .body("nixos system switched 🥳")
        .image_data(
            Image::try_from(image::load_from_memory(include_bytes!("../assets/icon.png")).unwrap())
                .unwrap(),
        )
        .show()?;
    #[allow(clippy::zombie_processes)]
    std::process::Command::from(cmd!(sh, "paplay /home/oscar/Music/sounds/Tink.wav").quiet())
        .spawn()
        .unwrap();
    Ok(())
}

fn git_commit_args() -> Vec<String> {
    let mut git_commit_args = vec![];
    if opt().amend {
        git_commit_args.push("--amend".to_owned());
        if opt().message.is_none() {
            git_commit_args.push("--no-edit".to_owned());
        }
    }
    if let Some(message) = &opt().message {
        git_commit_args.push("-m".to_owned());
        git_commit_args.push(message.to_owned());
    }
    git_commit_args
}
