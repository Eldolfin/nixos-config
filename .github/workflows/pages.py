import os
import subprocess as sp
import datetime
import logging
from typing import Union, Tuple, List, Dict, Literal

OUTPUT_FILE = "README.md"
LATEST_PATH = "latest"


def main():
    commits = os.listdir()
    commits = filter_commit_dir(commits)
    commits, commits_dates = get_commit_dates(commits)

    markdown = generate_markdown(commits, commits_dates)
    with open(OUTPUT_FILE, "w") as f:
        f.write(markdown)

    # create latest symlink to latest commit dir
    if os.path.exists(LATEST_PATH):
        os.remove(LATEST_PATH)
    os.symlink(commits[0], LATEST_PATH)


def filter_commit_dir(commits: List[str]) -> List[str]:
    return list(
        filter(
            lambda entry: os.path.isdir(entry)
            and not entry.startswith(".")
            and len(entry) == 40,
            commits,
        )
    )


def get_commit_date(commit: str) -> Union[datetime.datetime, Literal[False]]:
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
        timestamp_f: float = float(timestamp)
    except ValueError:
        # These are probably commits from deleted branches
        logging.debug(f"Failed to get commit date for commit {commit}. Skipping it...")
        return False
    parsed_date = datetime.datetime.fromtimestamp(timestamp_f)
    return parsed_date


def get_commit_dates(
    commits: List[str],
) -> Tuple[List[str], Dict[str, datetime.datetime]]:
    commits_dates = {}

    for commit in commits:
        date = get_commit_date(commit)
        if not date:
            continue
        commits_dates[commit] = date

    commits = list(filter(lambda c: c in commits_dates, commits))
    commits.sort(key=lambda c: commits_dates[c], reverse=True)

    return commits, commits_dates


def generate_markdown(
    commits: List[str], commits_dates: Dict[str, datetime.datetime]
) -> str:
    title = "# List of screenshots from the integration tests\n"
    contents = "\n".join(
        map(lambda c: commit_to_markdown(commits_dates[c], c), commits)
    )
    markdown = "\n".join((title, contents))

    return markdown


def commit_to_markdown(commit_date: datetime.datetime, commit: str) -> str:
    screenshots = list(sorted(os.listdir(commit)))

    def to_clickable_link(screenshot: str) -> str:
        name = screenshot.removesuffix(".png").replace("_", "-")
        return f"[{name}](https://github.com/Eldolfin/nixos-config/blob/{commit}/tests/{name}.nix)"

    def to_clickable_image(screenshot: str) -> str:
        return f"[![]({commit}/{screenshot})](https://eldolfin.github.io/nixos-config/{commit}/{screenshot})"

    header = "|".join(map(to_clickable_link, screenshots))
    separator = "|".join("-" * len(screenshots))
    body = "|".join(map(to_clickable_image, screenshots))

    table = "\n" + "\n".join((header, separator, body)) + "\n"
    title = (
        f"## [{commit_date}](https://github.com/Eldolfin/nixos-config/commit/{commit})"
    )

    row = "\n".join((title, table)) + "\n"
    return row


if __name__ == "__main__":
    main()
