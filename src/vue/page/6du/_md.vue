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
        &:after
          content ''
          border-top 1px dashed $a-color
          position absolute
          bottom -0.35em
          left 0
          transform scale(2, 0.5)
          transform-origin 0 0
          width 50%
          transition all 0.3s
        &:hover
          color #f50
          font-weight bold
          &:after
            border-style solid
            border-color #f50
        &.mdH
          color #ccc
          &:after
            content none
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
      ul.mdToc
        list-style none
        margin-left -0.96em
        color #555
        a
          color #555
          &:after
            border-top-color #555
          &:hover
            color #f50
            &:after
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
  (txt, elem)!->
    [h1, brief, meta, body] = await md-load txt
    $title h1
    @h1 = h1
    @html = md body
)
</script>
