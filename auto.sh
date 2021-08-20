
set -u
set -x
set -e


cp ~/.vimrc ./mac/.vimrc
cp ~/.zshrc ./mac/.zshrc
cp -R ~/biji ./mac/biji

git add .
git commit -m "auto"
git push
