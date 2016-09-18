#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR;

echo "Directory :" 
pwd

echo "Enter commit message : "
read message

find . -name '.DS_Store' -print -exec rm -rf {} \;

# commit and push to Github
git add .
git commit  -m "$message"
git push

