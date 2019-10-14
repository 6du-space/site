import
  \@/ls/vue/route

l = location
host = l.host
len = l.protocol.length+2+host.length

$('body').on 'click', 'a', (e) !->
  a = e.target
  if not a.target
    href = a.href
    if href
      if a.host == host
        pathname = a.pathname
        if not a.hash
          if pathname!=location.pathname
            route.push(pathname)
          return false
      else
        a.target = "_blank"
