import
  \@/ls/html
  \vue : Vue
  \@/ls/db/cache : {by-url}

style = \style

export default _ = (url, option, callback, get)~>
  _get = get or by-url
  var com
  html {
    destroyed:!~>
      for i in com.$options.destroyed
        i.call(com)
    beforeRoute:(to, from, next)!~>
      next !->
        {m} = @$refs
        m[style] = "display:none"
        ref = $(m)
        elem = (tag)~>
          ref.find(tag)._[0]
        template = elem \template
        option.template = "<main>#{template.innerHTML}</main>"
        component = Vue.component(
          'pug-'
          option
        )
        com := new component()
        await callback.call(
          com
          await _get url+"/"+to.params.f
        )
        com.$mount(template)
        @$nextTick ~>
          $title elem(\h1)?.innerText
          m.removeAttribute style
  },\/ + url
