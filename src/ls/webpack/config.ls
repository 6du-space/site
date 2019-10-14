require! <[
  html-webpack-plugin
  ./require_hacker.ls
  path
  webpack
  crypto
]>

digest = crypto.Hash.prototype.digest
crypto.Hash.prototype.digest = (base)->
  if base == "urlbase64"
    return digest.call(@, 'base64').replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '')
  return digest.apply(@,arguments)

ROOT = path.resolve(__dirname, '../..')
production = \production
is-production = process.env.NODE_ENV === production

module.exports = config =
  pages:
    index:
      entry:\src/index.ls
      template: \src/pug/page/index.pug
    site:
      entry:\src/site.ls
      template: \src/pug/page/site.pug
  productionSourceMap: false
  #   webpackConfig.module
  #     .rule('pug')
  #       .test(/\.pug$/)

  #       // this applies to <template lang="pug"> in Vue components
  #       .oneOf('vue-loader')
  #         .resourceQuery(/^\?vue/)
  #         .use('pug-plain')
  #           .loader('pug-plain-loader')
  #           .end()
  #       .end()

  #       // this applies to pug imports inside JavaScript, i.e. .pug files
  #       .oneOf('raw-pug-files')
  #         .use('pug-raw')
  #           .loader('raw-loader')
  #           .end()
  #         .use('pug-plain')
  #           .loader('pug-plain-loader')
  #           .end()
  #       .end()
    # config.rules.pug.options.basedir = ROOT
  chainWebpack: (config) !~>
    config.plugin(\provide)
      .use(
        webpack.ProvidePlugin
        [
          require('./provide.ls')
        ]
      )
    # config.plugin('copy').tap(
    #   (args)->
    #     args[0][0].from += "/**/*"
    #     console.log args[0][0]
    # )
    # config.plugin('css').tap(
    #   (args)->
    #     console.log args
    # )
    # config.plugins.delete('preload')
    # config.plugin('html-index').tap(
    #   (args) ->
    #     return args
    # )
  css: {
    extract: {
      filename: '[contenthash].css'
      chunkFilename: '[contenthash].css'
    }
    loaderOptions:
      less: {
        javascriptEnabled: true
        modifyVars:require("./antv.ls")
      }
  }
  configureWebpack: (config) !~>
    config.resolve.alias.vue$ = \vue/dist/vue.esm.js
    if is-production
      config.output <<<
        hashDigestLength : 7
        hashFunction: 'sha512'
        chunkFilename : '[contenthash].js'
        hashDigest : 'urlbase64'
        filename : '[contenthash].js'
    else
      config.devServer = {
        port: 6699
        headers: {
          'Access-Control-Allow-Origin': '*'
          'Access-Control-Allow-Headers': '*'
        }
        # historyApiFallback: false
      }

    # for i in config.plugins
    #   console.log i
    #   console.log i.toString
    #   for k,v of i
    #     console.log k,v

    for i in config.module.rules
      test = i.test
      # if test.test('.js')
      #     console.log i
      #else
      # if test.test('.css')
      #   for mod in i.oneOf
      #     for use in mod.use
      #       console.log use
      #     # use.options.fallback.options.name = '[name].[hash:8].[ext]'
      #else
      if test.test('.ttf')
        for use in i.use
          use.options.fallback.options.name = '[name].[hash:8].[ext]'
      else if test.test(".pug")
        for use in i.oneOf
          for loader in use.use
            if loader.loader == \pug-plain-loader
              loader.options = (
                loader.options or {}
              ) <<< {
                basedir : ROOT
                data:{
                  production : is-production
                }
              }
  #               # console.log loader
  # chainWebpack: (config) !->
  #   config.resolve.alias.set("@pug", path.resolve(__dirname, "./src/pug"))

if is-production
  cdn = require("../../config/cdn.txt")
  if not cdn
    cdn = '/'
  else if not cdn.startsWith '/'
    cdn = "//"+cdn
  config.publicPath = cdn
