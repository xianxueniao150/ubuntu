commitMessage=auto
if [ $# -eq 0 ]
  then
    echo $(date "+%Y-%m-%d")
else
  echo $1
fi
