#!/usr/bin/env bash
. `dirname "$BASH_SOURCE"`/root.sh

cd $ROOT

print() {
   echo -e "⚡ \033[33m$1\033[0m"
}

if [ ! \( -d "./font" \) ]; then
  print "clone font"
  git clone git@gitee.com:www-6du-space/font.git --depth=1
fi

if [ ! \( -e "./src/config" \) ]; then
  print "use default config"
  cp -r ./config.6du.host ./src/config
fi


if [ ! \( -e "./node_modules" \) ]; then
  print "install node modules"
  npx yarn
fi

if [ ! \( -e "./node_modules/ant-design-vue" \) ]; then
  print "install ant design vue"
  git clone https://github.com/6du-space/ant-design-vue.git --depth=1
  cd ant-design-vue
  npx yarn
  npx yarn dist
  cd ..
  mv ant-design-vue $ROOT/node_modules
fi

cd $ROOT
npx gulp

cd $ROOT
