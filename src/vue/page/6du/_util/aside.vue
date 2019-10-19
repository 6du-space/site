<style lang=stylus scoped>
.aside
  transform-origin 0 0
  user-select none
  top 0
  left 0
  z-index 9999
  position fixed
  height 100%
  background #fff
  /deep/
    &>.ohyeah-scroll-body
      display flex
      flex-flow column
      flex-shrink 0
      justify-content space-between
  &:after
    content ''
    position fixed
    left 300px
    width 1px
    background #ccc
    top 0
    z-index 1
    height 200%
    bottom 0
    transform scale(0.5)
    transform-origin 0 0
  &>.ohyeah-scroll-body>div>main>header
    margin 2rem
    padding-bottom 2rem
    display flex
    justify-content space-between
  /deep/
    footer
      padding 2.5rem 2rem
      a.btn
        line-height 1.8
        color #999
        padding 0.5rem 0 0.3rem
        display block
        font-size 1rem
        width 100%
        outline 0
        text-align center
        outline 1px dashed
        outline-color #ccc
        outline-offset 0
        border 1px dashed rgba(255, 255, 255, 0)
        transition all 1250ms cubic-bezier(0.19, 1, 0.22, 1)
        position relative
        overflow hidden
        width 6rem
        margin auto
        &:after
          background #f50
          content ''
          height 220%
          opacity 0.5
          position absolute
          top -75%
          transform rotate(35deg)
          transition all 550ms cubic-bezier(0.19, 1, 0.22, 1)
          left -55%
          width 30%
          z-index -9
        &:hover
          color #f50
          outline-color rgba(252, 70, 29, 0)
          outline-offset 1em
          border-color #f50
          border-style solid
        &:active
          color #fff
          background #f50
          &:after
            left 120%
            transition all 550ms cubic-bezier(0.19, 1, 0.22, 1)
    h2
      font-weight 100
      margin 0
      letter-spacing 0.1rem
      &.host
        font-family host
        font-size 1.4rem
        text-rendering geometricPrecision
    header, nav, menu
      position relative
      &:after
        content ''
        width 6rem
        left 50%
        margin-left -0.5 * @width
        border-bottom 1px solid #ccc
        bottom -1px
        transform scale(0.5)
        position absolute
    .pug
      display flex
      flex-direction column
      h2
        font-size 1.5rem
        margin 0.4rem 1rem 0
        text-indent 1rem
        letter-spacing 1.1rem
      h3
        font-weight 100
        font-size 0.8rem
        margin 0 1rem 0
        letter-spacing 0.38rem
        text-indent 0.1rem
      h2, h3
        font-family html
        text-align center
      header
        display flex
        flex-flow column
        .logo
          height 3rem
          width @height
          margin 2rem auto 2.55rem
          background-size contain
      nav, &>menu
        margin auto
        padding 2rem
        text-align center
        display flex
        justify-content center
        flex-direction column
        a
          padding 0.5rem
          font-size 1rem
          color #555
          &.NOW
            color #000
          &:hover
            color #f50
      &>menu
        writing-mode vertical-lr
</style>

<template lang=pug>
ohyeah.aside(width="300px" :noHor="true" thumbColor="rgba(0,0,0,.2)")
  main()
    header
      h2.host {{host}}
      x-ico.x(@click="$emit('update:x',true)")
    .pug(v-html="aside")
  footer(v-html="foot")
</template>

<script lang=ls>
export default _ = {
  props:{
    x:Boolean
  }
  data:->
    {
      aside:C.pug.aside
      foot:C.pug.foot
      host:location.hostname
    }

}
</script>
