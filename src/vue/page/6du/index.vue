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
    line-height 2
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
  div(ref="slider")
  .g2(ref="g2")
</template>

<script lang=ls>

import
  \@/ls/vue/route
  \vue : Vue
  \@antv/g2 : G2
  \@antv/data-set : {DataSet}
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

_render = (li, line-li, offset)->
  end = li[*-1].time
  begin-time = li[0].time
  start = Math.max(begin-time,end - offset*86400000)
  ds = new DataSet(
    state: {
      start
      end
    }
  )
  dv = ds.createView()
  dv.source(li).transform({
    type: \fold
    key: 'type' # key字段
    value: 'value' # value字段
    retains:<[sell time rate profit]>
  }).transform({
    type: \filter
    callback: ({time}) ~>
      time >= ds.state.start && time <= ds.state.end
  })
  slideDv = ds.createView()
  field = line-li[0][0]
  slideDv.source(li).transform({
    type: 'fold',
    key: 'type',
    value: 'value',
    retains:[\time field]
    fields: [field]
  })
  {g2,slider} = @$refs
  padding = [40 90 30 66]
  chart = new G2.Chart({
    container: g2
    forceFit: true
    padding:padding
    animate: false
    height: window.innerHeight - g2.offsetTop - 90
  })
  chart.source(dv, {
    time: {
      type: 'time',
      tickCount: 12,
      mask: 'YYYY-MM-DD'
    }
  })


  for [en,alias,color],pos in line-li
    chart.scale(en,{alias})
    label ={
      textStyle: {
        fill: color
      }
    }
    if pos==2
      label.offset = 40
    chart.axis(en, {label})
    chart.line().position("time*#en").color color
  chart.render!
  chart.interact(
    \slider
    {
      container: slider
      startRadio:  (start - begin-time)/ (end - begin-time)
      xAxis: 'time'
      height: 50
      yAxis: \value
      data: slideDv
      backgroundChart: {
        type: \line
        color: line-li[0][2]
      }
      backgroundStyle:{
        lineWidth: 1
        stroke: '#CCD6EC'
        fill: '#CCD6EC'
        fillOpacity: 0.1
      }
      onChange:(_ref)!~>
        startValue = _ref.startValue
        endValue = _ref.endValue
        ds.setState('start', startValue)
        ds.setState('end', endValue)
      padding : padding
    }
  )

render = [
(data)->
  li = []
  for [day,sell,buy] in data
    profit = sell - buy
    li.push {
      sell:Math.round(sell/10000)/100
      rate:Math.round(10000*profit/sell)/100
      profit:Math.round(profit/10000)/100
      time:day * 86400000
    }
  _render.call(
    @
    li
    [
      <[profit 毛利润 #f50]>
      <[rate 毛利率 #aaa]>
      <[sell 销售额 rgba(0,0,0,.1)]>
    ]
    183
  )
(data)->
  li = []
  base = data[0][1]
  for [day,sell,buy] in data
    profit = sell - buy
    li.push {
      sell:Math.round(100*sell/base)/100
      rate:Math.round(10000*profit/sell)/100
      time:day * 86400000
    }
  _render.call(
    @
    li
    [
      <[sell 销售价格指数 #369]>
      <[rate 价格指数毛利率 #ddd]>
    ]
    999
  )
]

export default _ = {
  beforeMount:!->
    city_li = await $api.json(\city)
    @city_li.splice 1, city_li.length, ...city_li

  beforeRoute:(to,from,next)!->
    o =  to.params
    o.indicator = Math.max(INDICATOR.indexOf(o.indicator),0)
    data = await $api.json _url(o)
    next !->
      for k of @now
        @now[k] = (o[k] - 0) or 0

      for i in <[g2 slider]>
        @$refs[i].innerHTML = ''

      if not data.length
        return

      render[o.indicator].call @,data


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
