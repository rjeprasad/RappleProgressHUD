#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR;

echo "Directory :" 
pwd

echo "Enter release version : "
read version

find . -name '.DS_Store' -print -exec rm -rf {} \;

pod lib lint

git tag '$version'
git push --tags

pod trunk push RappleProgressHUD.podspec