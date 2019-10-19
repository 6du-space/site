<style lang=stylus scoped>
@import url('//at.alicdn.com/t/font_1322410_38fadlk7pa2.css')
menu
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
menu
  top 0
</style>

<template lang=pug>
menu(v-if="rbar.length" :style="'width:'+(1.5*(.5+rbar.length))+'rem'")
  a.I(v-for="i in rbar" :class="'I-'+i")
</template>

<script lang=ls>
export default _ = {
  props:{
  }
  data:->
    {
        #msg
        #git
        #search
      rbar:<[
        search
      ]>
    }

}
</script>
