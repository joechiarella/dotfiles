# To create this repo
```
git init $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/.git/ --work-tree=$HOME'
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/.git/ --work-tree=$HOME'" >> $HOME/.zshrc
config config --local status.showUntrackedFiles no

config add .vimrc
config commit -m "add .vimrc"
```

# To clone this repo
```
echo ".cfg" >> .gitignore
git clone <remote-git-repo-url> $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/.git --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
```
