require './init.styl'

margin-bottom = (n)~>
  "margin-bottom:#{n}px;"

class TOAST
  ->
    @_li = []
    @_offset = 0

  new : (msg, option={})->
    {timeout, body, x} = Object.assign(
      {
        timeout:500
        body:$('body')
        x:0
      }
      option
    )
    if x
      _ = $.html()
      _ msg
      _ "<i "
      if typeof(x)=='string'
        _ """title="#{x}" """
      _ """class="I-x I"></i>"""
      msg = _.html()

    li = @_li
    elem = $ """<div class="toast" style="#{margin-bottom @_offset}">#{msg}</div>"""
    li.push elem
    helem = elem._[0]
    body.append(
      helem
    )
    @_offset += (18+helem.clientHeight)
    elem.x = ~>
      elem.addClass "x"
      setTimeout(
        ~>
          li.splice li.indexOf(elem), 1
          elem.remove()
          offset = 0
          for i,pos in li
            i = i._[0]
            i.style = margin-bottom(offset)
            offset += (18+i.clientHeight)
          @_offset = offset
        499
      )
    if x
      elem.find('.I-x').click elem.x
    if timeout
      setTimeout(
        elem.x
        timeout*1000
      )
    return elem

TOAST = new TOAST()

export default _ = ~>
  TOAST.new.apply TOAST, arguments
