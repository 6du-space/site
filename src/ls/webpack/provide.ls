module.exports = exports =
  $: \umbrellajs-6du

for i in "title f s id get".split(" ")
  exports['$'+i] = \@/ls/$/ + i + \.ls

