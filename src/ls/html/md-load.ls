li_dict = (li)~>
  r = {}
  for i in li
    pos = i.indexOf(':')
    if pos+1
        r[i.slice(0,pos).trim!] = i.slice(pos+1).trim!
  r

trim_empty = (txt)~>
  for i,pos in txt
    if i.trimEnd!
      return txt.slice(pos)
  return txt

export default _ = (txt)~>
  txt = txt.split("\n")
  for i,pos in txt
    if i.startsWith '# '
      h1 = h1 or i.slice(2).trim()
      break

  txt = trim_empty txt.slice(pos+1)

  pos = txt.indexOf('------')
  if pos+1
    head = txt.slice(0, pos)
    body = trim_empty txt.slice(pos+1)
  else
    head = []
    body = txt

  pos = head.lastIndexOf('---')
  if pos+1
    brief = head.slice(0, pos).join '\n'
    meta = head.slice(pos+1)
  else
    brief = ''
    meta = head

  return [
    h1
    brief
    li_dict meta
    body.join '\n'
  ]
