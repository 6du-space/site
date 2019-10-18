#!/usr/bin/env -S node -r ./livescript-transform-implicit-async/register

require! <[
  path
  fs
]>

filepath = (file)->
  path.resolve(__dirname,"..", file)

fileread = (file)->
  fs.readFileSync filepath(file), "utf-8"

html2txt = (cdn, pug)~>
  css = []
  js = []
  prefetch = {css:[], js:[]}
  for i in pug.split(">")
    try
      url = i.split("//")[1]
      url = url.split(" ")[0]
      url = url.slice(cdn.length)
    catch
      continue
    if i.indexOf("rel=stylesheet") > 0
      css.push url.slice(0,-4)
    else if i.indexOf('<script ') >= 0
      js.push url.slice(0,-3)
    else if i.indexOf('rel=prefetch') > 0
      [name, suffix] = url.split(".")
      prefetch[suffix].push(name)
  [
    css.join(' ')
    js.join(' ')
    prefetch.css.join(' ')
    prefetch.js.join(' ')
  ]

do ->
  txt = html2txt(
    fileread "src/config/cdn.txt"
    fileread 'dist/site.html'
  )
  fs.writeFileSync(filepath("dist/6"), txt.join('\n'))


