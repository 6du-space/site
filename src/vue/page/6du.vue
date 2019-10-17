<style lang=stylus>
body
  overflow hidden
</style>
<style lang=stylus scoped>
@import url('//at.alicdn.com/t/font_1322410_38fadlk7pa2.css')
.vue>main
  position absolute
  left 0
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
    .main
      background #fff
      display flex
      flex-flow column
      overflow visible
      height 100%
      article
        max-width 41em
</style>
<template lang=pug>
.vue
  //ohyeah.aside(width="300px" :noHor="true" thumbColor="rgba(0,0,0,.2)" ref="side")
  //  main()
  //    header
  //      h2.host {{host}}
  //      x-ico.x(@click="x=1")
  //    .pug(v-html="aside")
  //  footer(v-html="foot")
  main
    // a.menu(@click="x=0" ref="x")
    ohyeah.main(
      :noHor="true" height="" width=""
      thumbColor="rgba(0,0,0,.2)"
      ref="main"
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

  data:->
    {
    }
</script>
