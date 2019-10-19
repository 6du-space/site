require \pug-for-browser

runScript = (script) ->
  new Promise((reslove, rejected) !~>
    # 直接 document.head.appendChild(script) 是不会生效的，需要重新创建一个
    newScript = document.createElement('script')
    # 获取 inline script
    newScript.innerHTML = script.innerHTML
    # 存在 src 属性的话
    src = script.getAttribute('src')
    if src
      newScript.setAttribute 'src', src
    # script 加载完成和错误处理


    newScript.onerror = (err) !~>
      rejected()

    document.head.appendChild newScript
    if src
      newScript.onload = !~>
        reslove()
    else
      # 如果是 inline script 执行是同步的
      reslove()
    document.head.removeChild newScript
  )

setHTMLWithScript = (container, rawHTML) !~>
  container.innerHTML = rawHTML
  for i in container.querySelectorAll('script')
    await runScript i


export default _ = (mod, dir)->
  beforeRoute = mod.beforeRoute

  mod.beforeRoute = (to, from, next)->
    to.params.f = to.params.f or \index
    if dir.startsWith '/'
      url = \6du + dir
    else
      url = dir + "/" + to.params.f
    body = pug.render(
      await $get(
        url  + \.pug
      )
    )

    insert = !->
      setHTMLWithScript @$refs.m, body
    scroll = !->
      console.log to
      console.log decodeURIComponent(to.hash)
      console.log document.getElementById(decodeURIComponent(to.hash).slice(1))

    if beforeRoute
      beforeRoute(
        to
        from
        (func)!~>
          next !->
            insert.call @
            func.call @
            scroll.call @
      )
    else
      next !->
        insert.call @
        scroll.call @
  return mod

