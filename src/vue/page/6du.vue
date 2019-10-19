<style lang=stylus>
body
  overflow hidden
</style>
<style lang=stylus scoped>
@import url('//at.alicdn.com/t/font_1322410_38fadlk7pa2.css')
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
  left 301px
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
  x-aside(ref="side" :x.sync="x")
  main(:class="{bar:bar}")
    a.menu(@click="x=false" ref="x")
    menu(v-if="rbar.length" :style="'width:'+(1.5*(.5+rbar.length))+'rem'")
      a.I(v-for="i in rbar" :class="'I-'+i")
    ohyeah.main(
      :noHor="true" height="" width=""
      thumbColor="rgba(0,0,0,.2)"
      @onVerStart="scroll" @onScroll="scroll" ref="main"
    )
      router-view
</template>

<script lang=ls>
import
  \vue : Vue
  \@/vue/page/6du/_util/aside

preTop = 0
var timeout

Vue.component(\x-aside,aside)

export default _ =
  beforeRouteEnter : (to, from, next)!~>
    next (vm)!~>
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
      x:false
      bar:1
    }
</script>
