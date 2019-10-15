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
  \@/ls/html/pug
  \@/ls/db/cache : {li-get}

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

getBigInt48 = (txt, offset)~>
  ab8 = new ArrayBuffer(8)
  time8 = new Uint8Array(ab8)
  time = new Uint8Array(txt,0+offset,6)
  if 128 .&. time[0]
    n = 255
  else
    n = 0
  time8[0] = time8[1] = n
  time8.set(time,2)
  parseInt (new DataView(ab8)).getBigInt64()

_split = (txt)~>
  li = []
  offset = 0
  txt-len = txt.byteLength
  uint = new Uint8Array(txt)
  while offset < txt-len
    pos = begin = offset + 38
    while uint[pos] != 10 # \n 的 ascii 码 是 10
      ++pos
    time = getBigInt48(txt, offset)
    hash = txt.slice(6+offset,begin)
    li.push [
      time
      hash
      new TextDecoder("utf-8").decode uint.slice(begin,pos)
    ]
    offset := pos+1
  li

equal = (buf1, buf2) ~>
  return false if buf1.byteLength != buf2.byteLength
  dv1 = new BigInt64Array buf1
  dv2 = new BigInt64Array buf2
  len = dv1.length
  i = 0
  while i < len
    if dv1[i] != dv2[i]
      return false
    ++i
  true

export default _ = pug(
  \li
  * data:~>
      {
        li:[]
      }
  (li)!->
    pre_month = ''
    todo = []
    for [time,hash,url],pos in _split li

      if time > 0
        m = new Date(time*1000).toISOString().slice(0,7)
        if m != pre_month
          pre_month = m
          @li.push m

      todo.push li-get url, hash
    @li.splice(
      @li.length, todo.length, ... await Promise.all todo
    )

  (url)~>
    $get(
      url+\.js
      \arrayBuffer
    )
)

</script>
