import
  \@/file/logo.svg : svg
alert 1
console.log svg
console.log('%c ', "background:url(data:image/svg+xml;base64,#{btoa(svg)}) 50% 50% / contain no-repeat;padding:50px;margin:20px;")


