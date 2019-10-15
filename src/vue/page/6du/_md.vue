<style lang=stylus scoped>
main
  text-align justify
  margin auto
  max-width 41em
  padding 0 2em 20vh
  /deep/
    article
      $a-color = darken(#9ACA27, 15)
      a
        position relative
        color $a-color
        transition all 0.3s
        padding-bottom 0.2em
        border-bottom 1px dashed $a-color
        &:hover
          color #f50
          font-weight bold
          border-bottom 2px solid #f50
        &.mdH
          color #ccc
          vertical-align 0.1em
          margin-right 0.31em
          border 0
          &:hover
            color #f50
      a.mdback, .mdref a
        user-select none
        font-size 0.7em
        color #999
        &:hover
          color #f50
        &:after
          content none
      ol
        margin-left 1.12em
      ul.mdToc
        list-style none
        margin-left -0.96em
        margin-bottom 1.2em
        color #666
        a
          color #666
          border-color transparent
          &:hover
            color #f50
            border-color #f50
</style>
<template lang=pug>
main(ref="m")
</template>

<script lang=ls>
import
  \@/ls/html/md-load
  \@/ls/html/md
  \@/ls/html/pug
  \@/ls/vue/route

var esc
keydown = \keydown

export default _ = pug(
  \md
  * methods:
      x:!~>
        route.back!
    data:~>
      {
        h1:''
        html:''
      }
    destroyed:!~>
      window.removeEventListener(
        keydown
        esc
      )
    mounted:!->
      esc := (e)!~>
        if <[
          TEXTAREA
          INPUT
        ]>.indexOf(e.target.tagName)+1
          return
        if e.keyCode == 27
          @x!
      window.addEventListener(
        keydown
        esc
      )
  (txt)!->
    [h1, brief, meta, body] = await md-load txt
    @h1 = h1
    @html = md body
)
</script>
