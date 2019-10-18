<style lang=stylus scoped>
.vue>main>.ohyeah-scroll-box>.ohyeah-scroll-body>div>main
  width 100%
  font-size 1rem
  margin 0
  /deep/
    .ant-table-thead > tr > th .ant-table-column-sorter
      height 100%
      top 0
      margin-top 19px
    .ant-table-thead > tr > th .anticon-filter > svg, .ant-table-thead > tr > th .ant-table-filter-icon > svg
      margin-top -7px
    .ant-table-thead > tr > th, .ant-table-tbody > tr > td
      border-left 0
      border-right 0
  menu
    user-select none
    border-bottom 1px solid #eee
    padding 1em
    .ant-select
      min-width 6.8em
    a, .ML
      margin-left 1em
    a
      margin-left 1em
      padding 0.4em 0.5em
      color #666
      &.now
        background #FEDB41
        color #000
</style>
<template lang=pug>
// a-locale-provider(:locale="locale")
main
  menu
    label 城市
    a(v-for="i,pos in city_li" :class="{now:pos==now.city}" @click="now.city=pos") {{i[1]}}
  menu
    label 指标
    a(v-for="i,pos in indicator" :class="{now:pos==now.indicator}" @click="now.indicator=pos") {{i}}
  template(v-if="now.indicator==0")
    menu
      label 品类
      a(v-for="i,pos in kind" :class="{now:pos==now.kind}" @click="now.kind=pos") {{i}}
</template>

<script lang=ls>

import
  \@/ls/vue/route
  \vue : Vue
  \@antv/g2 : {G2}
  \@antv/g2-plugin-slider

#  \ant-design-vue/lib/locale-provider/zh_CN : zhCN
#   \ant-design-vue : {message, Button, DatePicker, LocaleProvider, TreeSelect, Table}
#   \ant-design-vue : {message, Button, DatePicker, LocaleProvider, TreeSelect, Table}

# Vue.prototype.$message = message
# Vue.use(LocaleProvider)
# Vue.use(TreeSelect)
# Vue.use(Table)
# Vue.use(Button)
# Vue.use(DatePicker)

INDICATOR = <[city cpi]>

_url = ({indicator, city, kind})~>
  city = city or 0
  if indicator
    li = [city]
  else
    li = [city, kind or 0]
  url = ([INDICATOR[indicator]].concat li).join \-

export default _ = {
  beforeMount:!->
    city_li = await $api.json(\city)
    @city_li.splice 1, city_li.length, ...city_li

  beforeRoute:(to,from,next)!->
    o =  to.params
    o.indicator = Math.max(INDICATOR.indexOf(o.indicator),0)
    li = await $api.json _url(o)
    console.log li
    next !->
      @li = li
      for k of @now
        @now[k] = (o[k] - 0) or 0

  computed:
    url:->
      _url @now

  watch:
    url :(url)!->
      if url == \city-0-0
        url = \/
      if location.pathname != \/ + url
        route.push url

  data:->
    {
      li:[]
      # locale: zhCN
      city_li:[
        [0, \全部]
      ]
      kind: <[
        全部
        生鲜
        标品
      ]>
      now:
        kind: 0
        city: 0
        indicator: 0
      indicator:<[
        毛利率
        价格指数
      ]>
    }
}
</script>
