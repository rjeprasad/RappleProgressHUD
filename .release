#!/bin/sh

DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR;

echo "Directory :" 
pwd

echo "Enter release version : "
read version

find . -name '.DS_Store' -print -exec rm -rf {} \;

echo "running 'pod lib lint'"
pod lib lint

echo "creating tag '$version'"
git tag $version
git push --tags

echo "pushing to cocoapods"
pod trunk push RappleProgressHUD.podspec