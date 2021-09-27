
set -u
set -x
set -e


cp ~/.vimrc ./mac/.vimrc
cp ~/.zshrc ./mac/.zshrc
cp ~/.config/nvim/init.vim ./mac/init.vim
cp -R ~/biji ./mac/biji

git add .

commitMessage=$(date "+%Y-%m-%d")
if [ $# -eq 1 ];then
    $commitMessage=$1
fi

git commit -m $commitMessage
git push
