#!/bin/bash

# skip if build is triggered by pull request
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# cleanup "_site"
rm -rf _site
mkdir _site

# clone remote repo to "_site"
git clone https://${GH_TOKEN}@github.com/edgibbs/edgibbs.github.io.git --branch development _site

# build with Jekyll into "_site"
bundle exec jekyll build

# push
cd _site
git config user.email "edward_gibbs@yahoo.com"
git config user.name "Ed Gibbs"
git add --all
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git remote -v
git push --force origin +master
