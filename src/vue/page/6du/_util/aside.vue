<style lang=stylus scoped></style>
<template lang=pug>
ohyeah.aside(width="300px" :noHor="true" thumbColor="rgba(0,0,0,.2)" ref="side")
  main()
    header
      h2.host {{host}}
      x-ico.x(@click="x=1")
    .pug(v-html="aside")
  footer(v-html="foot")
</template>

<script lang=ls>
export default _ =

</script>
