import
  \markdown-it : markdown
  \markdown-it-footnote-6du : footnote
  \markdown-it-block-image : blockImagePlugin
  \markdown-it-toc-and-anchor : markdownItTocAndAnchor

md = markdown({
  breaks : true
}).use(footnote).use(
  blockImagePlugin
  * outputContainer: 'p',
    containerClassName: "img"
).use(
  markdownItTocAndAnchor
  * tocClassName : \mdToc
    anchorClassName: \mdH
    anchorLinkSymbol: \§
    anchorLinkPrefix: \-
)

var _PATH

render_image = md.renderer.rules.image
md.renderer.rules.image = (tokens, idx, options, env, self) ->
  token = tokens[idx]
  src = \src
  s = token.attrGet(src)
  var s2
  if s.charAt(0) == "/" and s.charAt(1) != "/"
    s2 = s
  else if s.indexOf("://") < 0
    s2 = _PATH + "/md/" + s

  if s2
    token.attrSet(src, C.cdn.img+s2)
  token.attrSet(\crossOrigin,'')
  token.attrSet(\onload, '_mdImg(this)')
  return "<span class=img><i>#{render_image(tokens, idx, options, env, self)}</i></span>"

window._mdImg = (img)!~>
  width = 128
  height = Math.round(width*img.height/img.width)

  canvas = document.createElement('canvas')
  canvas.width = width
  canvas.height = height

  ctx = canvas.getContext('2d')
  ctx.drawImage(img, 0, 0,img.naturalWidth, img.naturalHeight,0,0,width,height)
  {data} = ctx.getImageData(0, 0, width, height)
  count = 0
  for row in [0, height-1]
    col = 0
    while col < width
      line = (width*row+col)*4
      ++col
      t = data.slice(line,line+4)
      if t[3] == 0 or (t[0]+t[1]+t[2])==765
        count+=1

  for col in [0,width-1]
    row = 1
    while row < height-1
      line = (width*row+col)*4
      ++row
      t = data.slice(line,line+4)
      if t[3] == 0 or (t[0]+t[1]+t[2])==765
        count+=1
  if count/(width+height-2) < 0.4
    img.parentNode.className="s"

export default _ = (txt, path)~>
  path = path or location.pathname
  path = path.slice(0,path.lastIndexOf("/"))
  _PATH := path
  md.render txt

