#!/usr/bin/env bash

_dir=$(cd "$(dirname "$0")"; pwd)

cd $_dir

if ! type real-favicon > /dev/null; then
yarn global add cli-real-favicon
fi

cd src/file

if [ -f "logo.cache.json" ]; then
echo "update ico"
real-favicon check-for-update --fail-on-update logo.cache.json
else
echo "create ico"
real-favicon generate logo.json logo.cache.json ../../public
fi


