module.exports = exports =
  $: \umbrellajs-6du

for i in "api title f s id get".split(" ")
  exports['$'+i] = \@/ls/$/ + i + \.ls

