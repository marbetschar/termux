# Termux Setup on Android

## Prerequisites

Install the following packages from F-Droid:

- **Required:**
    - Termux
    - Termux:API
    - Termux:Boot
    - Termux:Widget
- **Optional (but recommended):**
    - Termux:Styling

## Run Setup

Copy & Paste the following snippet into your Termux terminal and run it:

```bash
curl -sS -o termux-install.sh https://raw.githubusercontent.com/marbetschar/termux/main/install.sh && \
    chmod +x termux-install.sh && \
    ./termux-install.sh && \
    rm -f termux-install.sh
```

## Usage of `git-sync`

`git-sync` syncs your Git repository automatically at minute 13, 33, and 53 of each hour:

```shell
$ git-sync
Syncs your Git repositories automatically.

Usage: git-sync <command> [arguments, ...]

Commands:
    exec:           Executes git-sync for all configured directories
    list:           Lists all configured directories
    add <path>:     Adds <path> to git-sync
    remove <path>:  Removes <path> from git-sync
    edit:           Edit git-sync configuration file directly
```

To enable `git-sync` for a specific repository, run the following commands:

```shell
cd ~/storage/shared/Documents
git clone git@github.com:<username>/<repo>.git
cd <repo>
git-sync add $(pwd)
git-sync list
```
