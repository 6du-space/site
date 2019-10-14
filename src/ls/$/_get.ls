import
  \@/ls/gadget/spin : Spin
  \@/ls/gadget/toast : toast
  \lodash : {escape}

export default _ = !~>
  Spin.inc!

  url = arguments[0]
  arguments[0] = C.cdn.site+'/'+url

  try
    r = await fetch.apply(void, arguments)
  catch
    void

  Spin.done!

  if r
    {status} = r
    if r.ok or status == 412
      return await r.text()
  else
    status = 0

  switch status
    when 0
      msg = """网络无连接"""
    # when 403
    #   GO.ln("auth/login")
    else
      msg = """<span class=MR3>错误码</span>#{status}"""
  toast("""<a class=MR3 target="_blank" href="#{escape(arguments[0]).replace(/"/g,'\\"')}">#{escape url}</a>加载失败，"""+msg).addClass('ERR')

