require <[
  @/styl/page/index.styl
]>

import
  \@/ls/init.ls
  \@/router/index : router
  \vue : Vue
  \./index.vue : index

#Vue.config.productionTip = false

document.title = C.txt.title

id = 'VUE'
$('body').append("<div id=#{id} />")
new Vue({
  router
  render: (h) -> h(index)
}).$mount('#'+id)


