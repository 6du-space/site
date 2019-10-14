import
  \@/ls/gadget/spin : Spin
  \@/ls/gadget/toast : toast
  \lodash : {escape}

export default _ = (input, init, type="text")!~>
  if typeof(init) == \string
    type = init
    init = {}
  Spin.inc!

  url = input
  input = C.cdn.site+'/'+url
  try
    r = await fetch(input, init)
  catch
    void

  Spin.done!

  if r
    {status} = r
    if r.ok or status == 412
      return await r[type]()
  else
    status = 0

  switch status
    when 0
      msg = """网络无连接"""
    # when 403
    #   GO.ln("auth/login")
    else
      msg = """<span class=MR3>错误码</span>#{status}"""
  toast("""<a class=MR3 target="_blank" href="#{escape(input).replace(/"/g,'\\"')}">#{escape url}</a>加载失败，"""+msg).addClass('ERR')

