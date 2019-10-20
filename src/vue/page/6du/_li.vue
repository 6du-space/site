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
      justify-content space-between
      b.date
        width 3.4em
        padding-right 0.4em
        justify-content space-between
        display flex
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

TIMEZONE = new Date().getTimezoneOffset()*60

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
    if time > 0
      time = time - TIMEZONE
    li.push [
      new TextDecoder("utf-8").decode uint.slice(begin,pos)
      hash
      time
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
    li = _split li

    pos = 0
    push = ~>
      t = []
      pos-next = pos + 5
      li-t = li.slice(pos, pos-next)
      for [url,hash] in li-t
        t.push li-get url, hash
      t = await Promise.all t
      toadd = []
      for [url,hash,time],n in li-t
        if time > 0
          date = new Date(time*1000).toISOString().slice(0,19).replace("T",' ')
          m = date.slice(0,7)
          if m != pre_month
            pre_month := m
            toadd.push m
        else
            date = 0
        toadd.push [url,date].concat t[n]
      @li.splice @li.length, toadd.length, ...toadd
      pos := pos-next

    # 预先加载6篇，防止页面抖动
    await push!
    do ~>
      while pos < li.length
        await push!

  (url)~>
    $get(
      url+\.js
      \arrayBuffer
    )
)

</script>
