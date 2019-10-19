<style lang=stylus>
body
  overflow hidden
</style>
<style lang=stylus scoped>
@import url('//at.alicdn.com/t/font_1322410_38fadlk7pa2.css')
$aside-width = 300px
.aside
  transform-origin 0 0
  user-select none
  top 0
  left 0
  z-index 9999
  position fixed
  height 100%
  background #fff
  width $aside-width
  /deep/
    &>.ohyeah-scroll-body
      display flex
      flex-flow column
      flex-shrink 0
      justify-content space-between
  &:after
    content ''
    position fixed
    left $aside-width
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
      padding 2.5rem 2rem 6.4rem
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
$width = 1.5rem
a.menu
  width $width
  display inline-block
  position relative
/deep/
  x-ico.x
    width $width
    height @width
    line-height @width
    display inline-block
    position relative
    &:before, &:after
      top 0.75rem
      transition all 0.5s
      border-top 1px solid #555
      content ''
      position absolute
      width 150%
      margin-left -25%
    &:before
      transform scale(0.5) rotate(45deg)
    &:after
      transform scale(0.5) rotate(135deg)
    &:hover
      &:before, &:after
        border-color #f50
      &:after
        transform scale(0.65) rotate(45deg)
      &:before
        transform scale(0.65) rotate(135deg)
  /*
   width 1.2rem
   top: 2rem;
   &:before
     top .667rem
   &:after
     bottom .667rem
   &:before,&:after
     transition width .5s
     background #000
     content ""
     position absolute
     height 2px
     width 100%
     transition: all .5s
   &:after
     width 62%
   &:hover
     &:before,&:after
       height 1px
       background #f50
     &:after
       width 100%
       bottom .71rem
     &:before
       top .71rem
       width 62%
  */
.vue>main>menu
  transition all 1s
  top 0
  right 0
  background linear-gradient(-90deg, #F8F8F8, #F8F8F8 50%, transparent)
  position absolute
  height 1.5rem
  right 0
  top -(@height + 0.1rem)
  z-index 1
  text-align right
.vue>main.bar>menu
  top 0
.vue>main>a.menu
  border 1px solid #999
  top 2.02rem
  width 1.5rem
  left - @width
  transform scale(0.5)
  border-left 0
  background #f9f9f9
  transform-origin 0 0
  height 4rem
  border-radius 0 0.5rem 0.5rem 0
  transition all 0.5s
.vue>main
  position absolute
  left 1px + $aside-width
  top 0
  right 0
  bottom 0
  overflow hidden
  /deep/
    &>.ohyeah-scroll-box
      &>.ohyeah-scroll-vertical-track-h:hover
        background rgba(0, 0, 0, 0.05) !important
      &>.ohyeah-scroll-body
        flex-direction column
        &>main
          align-self center
          margin auto
    &>a.menu, &>menu
      position fixed
      z-index 9000
    &>menu
      display flex
      justify-content flex-end
      &:after
        transform scale(0.5)
        border-top 1px solid transparent
        bottom 0
        left -100%
        transform-origin 100% 0
        content ''
        right 0
        position absolute
        border-image linear-gradient(-90deg, #CFCFCF, #CFCFCF 50%, transparent)
        border-image-slice 10
      .I
        color #000
        font-size 0.85rem
        display inline-block
        text-align center
        height 1.5rem
        width @height
        line-height @height
        &:hover
          background #509dfc
          color #fff
        &.I-search
          font-weight 600
          right 0
    .main
      background #fff
      display flex
      flex-flow column
      overflow visible
      height 100%
      article
        max-width 41em
.vue>main.bar
  /deep/
    &>.main
      top 1.5rem
      &>.ohyeah-scroll-body
        top -1.5rem
@keyframes menuIn
  0%
    border-color #999
    background #f9f9f9
    border-radius 0 0.5rem 0.5rem 0
    width 1.5rem
  50%
    border-color #f50
    background #f50
    border-radius 0 3rem 3rem 0
    width 3rem
  100%
    border-color #999
    background #f9f9f9
    border-radius 0 0.5rem 0.5rem 0
    width 1.5rem
@keyframes menuBreathe1
  0%
    width 1.5rem
  100%
    width 4rem
@keyframes menuBreathe2
  0%
    width 4rem
  50%
    width 3rem
  100%
    width 4rem
@keyframes menuOut
  0%
    transform translate3d(0, 0, 0) scale(0.5)
  100%
    transform translate3d(-100%, 0, 0) scale(0.5)
@keyframes asideOut
  0%
    transform translate3d(0, 0, 0)
  100%
    transform translate3d(-100%, 0, 0) scale(0.5)
    opacity 0
.vue
  /deep/
    &>.aside
      transition all 0.5s
    &>main
      transition left 0.5s
  &.x
    /deep/
      &>main
        left 0
        &>a.menu
          left -1rem
        &.bar>a.menu
          left 0
          animation none
          &:hover
            border-color #f50
            background #f50
            border-radius 0 3rem 3rem 0
            animation 0.5s menuBreathe1, 1s menuBreathe2 0.5s infinite
        &>a.menu
          &.in
            animation 2s menuIn
      &>.aside
        animation 0.5s asideOut
        transform translate3d(-100%, 0, 0) scale(0.5)
</style>
<template lang=pug>
.vue(:class="{x:x}")
  ohyeah.aside(width="300px" :noHor="true" thumbColor="rgba(0,0,0,.2)" ref="side")
    main()
      header
        h2.host {{host}}
        x-ico.x(@click="x=1")
      .pug(v-html="aside")
    footer(v-html="foot")
  main(:class="{bar:bar}")
    a.menu(@click="x=0" ref="x")
    menu(v-if="rbar.length" :style="'width:'+(1.5*(1+rbar.length))+'rem'")
      a.I(v-for="i in rbar" :class="'I-'+i")
    ohyeah.main(
      :noHor="true" height="" width=""
      thumbColor="rgba(0,0,0,.2)"
      @onVerStart="scroll" @onScroll="scroll" ref="main"
    )
      router-view


</template>

<script lang=ls>

preTop = 0
var timeout

export default _ =
  beforeRouteEnter : (to, from, next)!~>
    next (vm)!~>
      vm.aside = C.pug.aside
      vm.foot = C.pug.foot
      vm.$nextTick !~>
        for i in vm._watchers
          if i.expression == "$route"
            i.cb.apply vm
            break

  watch:
    '$route':!->
      @$refs.main.scrollTo(0,0)
      {pathname} = location
      now = " NOW"
      for i in @$refs.side.$el.querySelectorAll('a')
        {className} = i
        exist = className.indexOf(now) + 1
        if i.pathname == pathname
          if not exist
            i.className = className + now
        else if exist
            i.className = className.replace(now,'')

    x:(n)!->
      cls = \in
      x = $(@$refs.x)
      if n
        x.addClass cls
        timeout := setTimeout(
          !~>
            x.removeClass cls
          2000
        )
      else
        clearTimeout timeout
        x.removeClass cls
  methods:
    scroll:!->
      offset = 64
      bar = @bar
      {scrollTop} = @$refs.main.getScrollInfo!
      if scrollTop
        diff = preTop - scrollTop
        if diff < 0
          preTop := scrollTop
          if bar
            @bar = 0
        else
          if diff > offset
            preTop := scrollTop
            if not bar
              @bar = 1
      else
        preTop := scrollTop
        if not bar
          @bar = 1
  data:->
    {
        #msg
        #git
        #search
      rbar:<[
        search
      ]>
      x:0
      bar:1
      aside:''
      foot:''
      host:location.hostname
    }
</script>
