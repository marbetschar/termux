#!/data/data/com.termux/files/usr/bin/bash

git_sync() {
    GIT_ROOT=$1
    GIT_ROOT="${GIT_ROOT/#\~/$HOME}" # expand tilde in path

    if [ ! -d $GIT_ROOT ] || [ ! -d $GIT_ROOT/.git ]; then
        echo "Git Sync: $GIT_ROOT - Not a valid directory. Skipping..."

    else
        echo "Git Sync: $GIT_ROOT - Starting..."
        cd $GIT_ROOT
        git config --global pack.windowMemory "100m"
        git config --global pack.packSizeLimit "100m"
        git config --global pack.threads "1"
        git pull --rebase
        git add --all
        git commit -m "Auto commit: $(date '+%Y-%m-%d %H:%M:%S')"
        git pull --rebase
        git push
        echo "Git Sync: $GIT_ROOT - Complete."
    fi
}

git_sync_main() {
    if [ -f ~/.termux/conf.d/git-sync.conf ]; then
        while IFS= read GIT_ROOT; do
            if [ -n "$GIT_ROOT" ]; then # string length is _not_ zero
                git_sync $GIT_ROOT
            fi
        done < ~/.termux/conf.d/git-sync.conf
    fi

    git_sync ~/.termux
    touch ~/.termux/conf.d/git-sync.conf
}
