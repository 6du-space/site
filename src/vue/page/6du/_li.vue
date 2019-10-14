<style lang=stylus scoped>
main.pug
  list-style none
  margin auto
  max-width 41em
  padding 0 2em 20vh
main.pug /deep/
  &>main
    &>h2.date
      font-size 1.4em
      padding-top 0.2rem
      text-shadow 1px 1px 0 #aaa
      margin 0
    &>h2.date:first-child
      padding-top 0.2rem
      margin-top 0
    &>li
      margin-top 1.5rem
    &>li>section
      margin-top 1rem
    &>li>a.h2
      font-family html
      font-size 1.25rem
      line-height 1.35
      text-shadow 1px 1px 0 #eee
      font-weight bold
      color #000
      position relative
      padding-bottom 0.6rem
    &>li>a.h2:after, &>li>a.h2:before
      border-top 1px solid #f50
      content ''
      position absolute
      left 0
      bottom 0
    &>li>a.h2:before
      width 200%
      border-image linear-gradient(90deg, #333, #eee 20%, transparent)
      border-image-slice 10
      transform scale(0.5)
      transform-origin 0 0
    &>li>a.h2:after
      width 0
      transition all 0.5s
    &>li>a.h2:hover
      color #f50
      text-shadow none
    &>li>a.h2:hover:after
      width 100%
</style>
<template lang=pug>
main.pug(ref="m")
</template>

<script lang=ls>
import
  \@/ls/html/md-load
  \@/ls/html/md
  \@/ls/html/pug

#bufferInt64 = (buf) ~>
#  ab = new ArrayBuffer buf.length+2
#  view = new Uint8Array ab
#  i = 0
#  view[0] = buf[0]
#  view[1] = buf[0]
#  i = 0
#  while i < buf.length
#    view[2+i] = buf[i]
#    ++i
#  view = new DataView(ab)
#  return view.getBigInt64()

_split = (txt)~>
  console.log typeof(txt)
  li = []
  offset = 0
  txt-len = txt.length-1
  while offset < txt-len
    pos = begin = offset + 38
    time = txt.slice(0+offset,6+offset)
    hash = txt.slice(6+offset,begin)
    console.log pos
    while txt[pos] != '\n'
      ++pos
    console.log begin, pos
    console.log txt.slice(begin,pos)
    offset := pos
  console.log li
  li

export default _ = pug(
  \li
  * data:~>
      {
        li:[]
      }
  (txt, elem)!->
    $title elem(\h1).innerText
    pre_month = ''
    for i,pos in _split txt
      [time,hash,path] = i.split(' ')
      if time > 0
        m = new Date(time*1000).toISOString().slice(0,7)
        if m != pre_month
          pre_month = m
          @li.push m

      [h1, brief, meta] = await md-load await $f "md/#path"
      @li.push [
        path
        meta.链接标题 or h1
        md brief
      ]
  (url)~>
    $get(
      url+\.js
      {
        responseType:\arraybuffer
      }
    )
)

</script>
