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
a-locale-provider(:locale="locale")
  main
    menu
      label 粒度
      a 周
      a 月
      a.now 季
      a 年
      a-range-picker.ML
    menu
      label 店龄
      a 一个月
      a 两个月
      a.now 三个月
      a 四个月及以上
    menu
      label 品类
      a-tree-select.ML(
        :treeData="city"
        :allowClear="true"
        :treeDefaultExpandedKeys="['0-0']"
        :treeCheckStrictly="true"
        placeholder="请选择点选"
        treeCheckable
      )
    menu
      label 主管
      a-tree-select.ML(
        :treeData="city"
        :allowClear="true"
        :treeDefaultExpandedKeys="['0-0']"
        :treeCheckStrictly="true"
        placeholder="请选择点选"
        treeCheckable
      )
    menu
      label 城市
      a-tree-select.ML(
        :treeData="city"
        :allowClear="true"
        :treeDefaultExpandedKeys="['0-0']"
        :treeCheckStrictly="true"
        placeholder="请选择点选"
        treeCheckable
      )
    a-table(
      :columns="column" :dataSource="table" @change="onChange"
      :pagination="false"
    )
</template>

<script lang=ls>

import
  \vue : Vue
  \ant-design-vue/lib/locale-provider/zh_CN : zhCN
  \ant-design-vue : {message, Button, DatePicker, LocaleProvider, TreeSelect, Table}

Vue.prototype.$message = message
Vue.use(LocaleProvider)
Vue.use(TreeSelect)
Vue.use(Table)
Vue.use(Button)
Vue.use(DatePicker)

export default _ = {
  data:->
    {
      locale: zhCN
      column:  [{
        title: '时间',
        dataIndex: 'name',
        onFilter: (value, record) ~> record.name.indexOf(value) === 0,
        sorter: (a, b) ~> a.name.length - b.name.length,
      },
      {
        title: '投入产出',
        dataIndex: 'age',
        sorter: (a, b) ~> a.age - b.age,
      },
      {
        title: '回本周期',
        dataIndex: 'age',
        sorter: (a, b) ~> a.age - b.age,
      },
      {
        title: '品类',
        dataIndex: 'age',
        sorter: (a, b) ~> a.age - b.age,
      },
      {
        title: '主管',
        dataIndex: 'age',
        sorter: (a, b) ~> a.age - b.age,
      },
      {
        title: '城市',
        dataIndex: 'address',
        onFilter: (value, record) ~> record.address.indexOf(value) === 0,
        sorter: (a, b) ~> a.address.length - b.address.length,
      }
      ]
      table:[{
        key: '1',
        name: 'John Brown',
        age: 32,
        address: 'New York No. 1 Lake Park',
      }, {
        key: '2',
        name: 'Jim Green',
        age: 42,
        address: 'London No. 1 Lake Park',
      }, {
        key: '3',
        name: 'Joe Black',
        age: 32,
        address: 'Sidney No. 1 Lake Park',
      }, {
      }, {
        key: '3',
        name: 'Joe Black',
        age: 32,
        address: 'Sidney No. 1 Lake Park',
      }, {
      }, {
        key: '3',
        name: 'Joe Black',
        age: 32,
        address: 'Sidney No. 1 Lake Park',
      }, {
      }, {
        key: '3',
        name: 'Joe Black',
        age: 32,
        address: 'Sidney No. 1 Lake Park',
      }, {
      }, {
        key: '3',
        name: 'Joe Black',
        age: 32,
        address: 'Sidney No. 1 Lake Park',
      }, {
        key: '4',
        name: 'Jim Red',
        age: 32,
        address: 'London No. 2 Lake Park',
      }]
      onChange:(pagination, filters, sorter) ~>
        console.log('params', pagination, filters, sorter)
      city: [
          {
            title: '新开城市',
            value: '0-0-1',
            key: '0-0-1',
            children: [
              {
                title: '杭州',
                value: '0-0-2',
                key: '0-0-2',
              }
              {
                title: '南京',
                value: '0-0-3',
                key: '0-0-3',
              }
            ]
          }
          {
            title: '成熟城市',
            value: '0-0-4',
            key: '0-0-4',
            children: [
              {
                title: '合肥',
                value: '0-0-5',
                key: '0-0-5',
              }
              {
                title: '武汉',
                value: '0-0-6',
                key: '0-0-6',
              }
            ]
          }
          {
            title: '全部城市',
            value: '0-0-4',
            key: '0-0-4',
            children: [
              {
                title: '合肥',
                value: '0-0-5',
                key: '0-0-5',
              }
              {
                title: '武汉',
                value: '0-0-6',
                key: '0-0-6',
              }
            ]
          }
      ]
    }
}
</script>
