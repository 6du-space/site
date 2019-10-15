import
  \@/ls/html
  \vue : Vue

export default _ = (url, option, callback, get)~>
  _get = get or (uri)~>
    $f uri
  var com
  html {
    destroyed:!~>
      for i in com.$options.destroyed
        i.call(com)
    beforeRoute:(to, from, next)!~>
      next !->
        ref = $(@$refs.m)
        elem = (tag)~>
          ref.find(tag)._[0]

        template = elem \template
        option.template = "<main>#{template.innerHTML}</main>"
        component = Vue.component(
          'pug-'
          option
        )
        com := new component().$mount(template)
        callback.call(
          com
          await _get url+"/"+to.params.f
          elem
        )
  },\/ + url
