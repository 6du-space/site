#!/usr/bin/env bash
. `dirname "$0"`/sh/init.sh
rm -rf public
npx yarn run build

./sh/html2txt.ls

cd dist/
cp ../sh/package.json .
npm version patch
npm publish
mv package.json ../sh/

git add -u
git commit -m "dist"
cd $ROOT
ossutil cp dist/  oss://6d2 --recursive --update
