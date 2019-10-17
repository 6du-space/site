<style lang=stylus scoped>
.vue>main>.ohyeah-scroll-box>.ohyeah-scroll-body>main
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
    a(v-for="i,pos in city_li" :class="{now:pos==city_now}" @click="city_now=pos") {{i[1]}}
  menu
    label 指标
    a(v-for="i,pos in indicator" :class="{now:pos==indicator_now}" @click="indicator_now=pos") {{i}}
  template(v-if="indicator_now==0")
    menu
      label 品类
      a.now 全部
      a 生鲜
      a 标品
</template>

<script lang=ls>

import
  \vue : Vue
#  \ant-design-vue/lib/locale-provider/zh_CN : zhCN
#   \ant-design-vue : {message, Button, DatePicker, LocaleProvider, TreeSelect, Table}
#   \ant-design-vue : {message, Button, DatePicker, LocaleProvider, TreeSelect, Table}

# Vue.prototype.$message = message
# Vue.use(LocaleProvider)
# Vue.use(TreeSelect)
# Vue.use(Table)
# Vue.use(Button)
# Vue.use(DatePicker)

export default _ = {
  beforeMount:!->
    city_li = await $api.json(\city)
    @city_li.splice 1, city_li.length, ...city_li
    console.log @city_li
  data:->
    {
      # locale: zhCN
      city_li:[
        [0, \全部]
      ]
      city_now:0
      indicator_now: 0
      indicator:<[
        毛利率
        价格指数
      ]>
    }
}
</script>
