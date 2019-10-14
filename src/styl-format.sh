#!/usr/bin/env bash
cd `dirname "$0"`
stylus-supremacy format ./**/*.styl -r -p styl/supremacy.yaml
