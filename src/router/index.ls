import
  \@/ls/vue/route.ls

URL = []
for k,v of C.url
  URL.push [":f(#v)","_"+k]

route.add [
  [
    \*
    \6du
    URL.concat [
      #[
      #  ":f(|)"
      #  \index
      #]
      [
        "*"
        \_404
      ]
    ]
  ]
]

export default _ = route
