#!/usr/bin/env bash
. `dirname "$0"`/sh/init.sh

cd $ROOT
if [ ! \( -e "./public/6.js" \) ]; then
  print "init public"

  dirpath=public/.cache/git/github.com/6du-plugin
  mkdir -p $dirpath
  plugin=../plugin

  for D in $plugin/*; do
    rm -rf $dirpath/`basename $D`
    ln -s ../../../../../$D $dirpath/`basename $D`
  done

  cd $ROOT/public
  6du -y -d .
  rm -rf 6du/6.js
  ln -s ../../sh/6.js 6du
  rm -rf md li pug

  site=../../sh/site
  for D in $site/_/*; do
    rm -rf `basename $D`
    ln -s $D .
  done

  cd 6du
  for suffix in pug yaml; do
    for D in ../$site/6du/*.$suffix; do
      rm -rf `basename $D`
      ln -s $D .
    done
  done
  cd ..

  6du
fi

npx yarn run serve

