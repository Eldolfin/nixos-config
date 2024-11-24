import os
import subprocess as sp
import datetime
import logging

OUTPUT_FILE = "README.md"


def main():
    commits = os.listdir()
    commits = list(
        filter(
            lambda entry: os.path.isdir(entry)
            and not entry.startswith(".")
            and len(entry) == 40,
            commits,
        )
    )

    commits_dates = {}

    for commit in commits:
        cmd = sp.run(
            [
                "git",
                "show",
                "-q",
                "--pretty=format:'%ct'",
                commit,
                "--",
            ],
            capture_output=True,
            text=True,
        )
        timestamp: str = cmd.stdout
        timestamp = timestamp.strip("'")
        try:
            timestamp: float = float(timestamp)
        except ValueError:
            logging.warn(
                f"Failed to get commit date for commit {commit}. Skipping it..."
            )
            continue
        parsed_date = datetime.datetime.fromtimestamp(timestamp)
        commits_dates[commit] = parsed_date

    commits = list(filter(lambda c: c in commits_dates, commits))
    commits.sort(key=lambda c: commits_dates[c], reverse=True)

    with open(OUTPUT_FILE, "w") as f:
        f.write("# List of screenshots from the integration tests\n")
        for commit in commits:
            f.write(f"## {commits_dates[commit]}\n")
            f.write(
                f"commit: [{commit}](https://github.com/Eldolfin/nixos-config/commit/{commit})\n"
            )
            screenshots = list(os.listdir(commit))

            # Header
            f.write("|")
            for screenshot in screenshots:
                name = screenshot.removesuffix(".png").replace("_", "-")
                f.write(
                    f"[{name}](https://github.com/Eldolfin/nixos-config/blob/{commit}/tests/{name}.nix)|"
                )
            f.write("\n")

            f.write("|" + "-|" * len(screenshots) + "\n")

            # Images
            f.write("|")
            for screenshot in screenshots:
                f.write(
                    f"[![]({commit}/{screenshot})](https://eldolfin.github.io/nixos-config/{commit}/{screenshot})"
                )
                f.write("|")
            f.write("\n")


if __name__ == "__main__":
    main()
