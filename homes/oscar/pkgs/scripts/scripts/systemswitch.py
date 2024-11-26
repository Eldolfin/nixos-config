#!/usr/bin/env python
import argparse
import subprocess as sp
import sys
import json
import time
import os

LOADING_ICONS = ["⢿", "⣻", "⣽", "⣾", "⣷", "⣯", "⣟", "⡿"]
MAX_GH_RUN_LIST_ATTEMPS = 20
NIXOS_CONFIG_REPO_PATH = "/etc/nixos/"


def shell(cmd: str):
    cmd = cmd.strip()
    res = sp.run(["sh", "-c", cmd])
    if res.returncode:
        print(
            f"Command '{cmd}' failed with return code '{res.returncode}'",
            file=sys.stderr,
        )
        sys.exit(res.returncode)


def get_last_gh_run_id(dry_run: bool) -> str:
    cmd = [
        "gh",
        "run",
        "list",
        "-L",
        "1",
        "--json",
        "databaseId",
        "--jq",
        ".[0].databaseId",
    ]

    if dry_run:
        print(" ".join(cmd))
        return ""

    return sp.run(
        cmd,
        capture_output=True,
        text=True,
    ).stdout.strip()


def main():
    parser = argparse.ArgumentParser(
        description="A helper script to edit my nixos config files. Edit, commit, build and push",
        allow_abbrev=True,
    )
    parser.add_argument(
        "--amend", help="Pass --ammend to git commit", action="store_true"
    )
    parser.add_argument(
        "-b",
        "--build",
        help="Only build, do not edit or commit",
        action="store_true",
    )
    parser.add_argument("-u", "--pull", help="Git pull first", action="store_true")
    parser.add_argument("-m", "--message", help="Message to use in the commit")
    parser.add_argument(
        "-n",
        "--dry-run",
        help="Do not execute anything, only print out the commands that would be run otherwise",
        action="store_true",
    )
    parser.add_argument(
        "--no-commit", help="Do not run git commit", action="store_true"
    )
    parser.add_argument("--no-push", help="Do not run git push", action="store_true")
    parser.add_argument(
        "--no-build",
        help="Do not build+switch to the new configuration",
        action="store_true",
    )
    parser.add_argument(
        "-l",
        "--lazy",
        help="Use lazygit to add and commit",
        action="store_true",
    )
    parser.add_argument("--upgrade", help="Update flakes", action="store_true")
    parser.add_argument(
        "rest", help="Arguments to pass to the editor", nargs=argparse.REMAINDER
    )
    parser.add_argument("-f", "--force", help="Force git push", action="store_true")
    args = parser.parse_args()

    sh = shell
    cd = os.chdir
    if args.dry_run:
        sh = print
        cd = lambda path: print(f"cd {path}")

    git_commit_args = []
    if args.amend:
        git_commit_args.append("--amend")
        if not args.message:
            git_commit_args.append("--no-edit")
    if args.message:
        git_commit_args.append("-m")
        git_commit_args.append(f'"{args.message}"')
    git_commit_args = " ".join(git_commit_args)

    cd(NIXOS_CONFIG_REPO_PATH)

    if args.pull:
        sh("git pull")

    if args.upgrade:
        cd(NIXOS_CONFIG_REPO_PATH + "homes/oscar/")
        sh("nix flake update")
        cd(NIXOS_CONFIG_REPO_PATH)
        sh("nix flake update")

    if not args.build and not args.upgrade:
        if args.rest == []:
            sh("$EDITOR .")
        else:
            sh("$EDITOR " + " ".join(args.rest))

    if not args.build and not args.no_commit:
        if args.lazy:
            sh("lazygit")
        else:
            sh("git add .")
            sh("git commit " + git_commit_args)

    if not args.no_build:
        sh("nh os switch /etc/nixos")

    if not args.build and not args.no_commit and not args.no_push:
        last_run_id_before = get_last_gh_run_id(args.dry_run)

        sh("git push" + " --force" if args.force else "")

        new_last_run_id = last_run_id_before
        i = 0
        while new_last_run_id == last_run_id_before:
            print(
                "\rWaiting for the github ci to start "
                + LOADING_ICONS[i % len(LOADING_ICONS)],
                end="",
                file=sys.stderr,
            )
            new_last_run_id = get_last_gh_run_id(args.dry_run)
            if i > MAX_GH_RUN_LIST_ATTEMPS:
                print(
                    "\rGiving up on watching the github workflow",
                    file=sys.stderr,
                )
                new_last_run_id = False
                break
            i += 1
        if new_last_run_id:
            print()
            sh(f"gh run watch {new_last_run_id}")


if __name__ == "__main__":
    main()
