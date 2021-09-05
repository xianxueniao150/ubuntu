
set -u
set -x
set -e


cp ~/.vimrc ./mac/.vimrc
cp ~/.zshrc ./mac/.zshrc
cp ~/.config/nvim/init.vim ./mac/init.vim
cp -R ~/biji ./mac/biji

git add .
git commit -m "auto"
git push
