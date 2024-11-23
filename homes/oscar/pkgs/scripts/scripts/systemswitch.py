#!/usr/bin/env python
import argparse
import subprocess as sp
import sys

def shell(cmd: str):
    cmd = cmd.strip()
    res = sp.run(['sh', '-c', cmd])
    if res.returncode:
        print(f"Command '{cmd}' failed with return code '{res.returncode}'")
        sys.exit(res.returncode)
    res.check_returncode()

def dry_run(cmd: str):
    print(cmd)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--amend", help="Pass --ammend to git commit",action="store_true")
    parser.add_argument("--build", help="Only build, do not edit or commit", action="store_true")
    parser.add_argument("--pull", help="Git pull first", action="store_true")
    parser.add_argument("-m", "--message", help="Message to use in the commit")
    parser.add_argument("--dry-run", help="Do not execute anything, only print out the commands that would be run otherwise", action="store_true")
    parser.add_argument("--no-commit", help="Do not run git commit", action="store_true")
    args = parser.parse_args()

    git_commit_args = []
    if args.amend:
        git_commit_args.append("--amend")
        if not args.message:
            git_commit_args.append("--no-edit")
    if args.message:
        git_commit_args.append("-m")
        git_commit_args.append(f'"{args.message}"')
    git_commit_args = ' '.join(git_commit_args)

    run = shell
    if args.dry_run:
        run = dry_run

    run("cd /etc/nixos/")

    if args.pull:
        run("git pull")

    if not args.build:
        run("$EDITOR .")

    if not args.build and not args.no_commit:
        run("git add .")
        run("git commit " + git_commit_args)

    run("nh os switch /etc/nixos")

    if not args.build and not args.no_commit:
        run("git push")

if __name__ == "__main__":
    main()
