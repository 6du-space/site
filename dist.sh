#!/usr/bin/env bash
. `dirname "$0"`/sh/init.sh
rm -rf public
npx yarn run build

./sh/html2txt.ls

cd dist/
cp ../src/config/package.json .
npm version patch
npm publish
mv package.json ../src/config

git add -u
git commit -m "dist"
cd $ROOT
ossutil cp dist/ oss://`cat src/config/oss.bucket.txt` --recursive --update
