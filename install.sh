#!/data/data/com.termux/files/usr/bin/bash

termux_install() {
    echo "Termux - Start install..."

    pkg upgrade -y
    pkg install termux-api termux-services cronie -y

    echo "Termux - Grant access to your local file storage..."
    termux-setup-storage
    read -p "Termux - Access to file storage granted [Enter to continue]."

    echo "Termux - Install complete."
}

termux_setup() {
    if [ -d ~/.termux/.git ]; then
        echo "Termux - Setup was already run before. Skipping..."

    else
        echo "Termux - Start setup..."

        mv ~/.termux ~/termux-install
        git clone git@github.com:marbetschar/termux.git ~/.termux
        mv ~/termux-install/* ~/.termux/
        rmdir ~/termux-install

        echo "Termux - Setup complete."
    fi

    echo "Termux - Start configuration..."
    
    echo "Termux - Add ~/.termux/bin to PATH..."
    touch ~/.bashrc && (cat ~/.bashrc | grep 'PATH=') || echo "export PATH=\$PATH:~/.termux/bin" >> ~/.bashrc
    source ~/.bashrc

    echo "Termux - Start services daemon..."
    . $PREFIX/etc/profile
    sv-enable crond

    if [ ! -d ~/.cache ]; then # solves "No such file or directory" issue when editing crontab
        mkdir ~/.cache
    fi

    if [ ! $(crontab -l | grep 'git-sync') ]; then
        echo "Termux - Schedule git-sync via cron..."
        crontab -l > ~/.termux/.crontab
        echo "7 7-23/1 * * * ~/.termux/bin/git-sync exec" >> ~/.termux/.crontab
        crontab -T ~/.termux/.crontab && crontab ~/.termux/.crontab
        rm ~/.termux/.crontab
    fi

    echo "Termux - Configuration complete."
}

git_install() {
    echo "Git - Start Git install..."
    pkg install git -y
    echo "Git - Install complete."
}

git_setup() {
    if [ -f ~/.ssh/id_ed25519.pub ]; then
        echo "Git - Setup was already run before. Skipping..."

    else
        echo "Git - Start Git setup..."

        echo -n "Git - User Name:   " && read GIT_USER_NAME
        echo -n "Git - User E-Mail: " && read GIT_USER_EMAIL
        git config --global user.name $GIT_USER_NAME
        git config --global user.email $GIT_USER_EMAIL
        git config --global --add safe.directory '*' # fix fatal: detected dubious ownership in repository
        if [ ! -f ~/.ssh/id_ed25519.pub ]; then
            ssh-keygen -t ed25519 -C $GIT_USER_EMAIL
        fi
        cat ~/.ssh/id_ed25519.pub | termux-clipboard-set
        echo "Git - The public key has been copied to your clipboard."
        termux-open-url "https://github.com/settings/keys"
        read -p "Git - Add the public key to your GitHub account [Enter to continue]..."   

        echo "Git - Setup complete."
    fi
}

main() {
    read -p "IMPORTANT: Make sure you installed Termux:Boot, Termux:API and Termux:Widget before you continue [Enter to continue]"

    termux_install
    git_install
    git_setup
    termux_setup

    echo "Installation complete."
}
main
