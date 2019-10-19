import
  \vue-router : VueRouter
  \./plugin : Vue
  \@/ls/gadget/spin : Spin

Vue.use(VueRouter)

_mod = (path)~>
  mod = (await ``import``("@/vue/page"+path+".vue")).default
  before = mod.beforeRoute
  if before
    enter = mod.beforeRouteEnter
    mod.beforeRouteEnter = (to, from, next)->
      before(
        to
        from
        (f)~>
          if enter
            enter.call to, from, (vm)~>
              f.call vm
              next(vm)
          else
            next(
              (vm)~>
                f.call vm
            )
      )

    update = mod.beforeRouteUpdate
    mod.beforeRouteUpdate = (to, from, next)->
      if to.path == from.path
        return
      _next = (f)~>
        f.call @
        next()
      before(to, from,  _next)
      update?.apply @,arguments

    delete mod.beforeRoute
  return mod

_component = (path)->
  ->
    Spin.inc!
    try
      mod = await _mod(path)
    finally
      Spin.done!
    return mod

export default R = new VueRouter {
  mode: 'history'
#  base: process.env.BASE_URL
}


add = (li, prefix="/")~>
  routes = []
  for path in li
    [path, component, children] = path
    compath = prefix+component
    r = {
      path
      component:_component(compath)
    }
    if children
      r.children = add(children,compath+"/")
    routes.push r
  return routes

HISTORY = []
BACK = false

R.beforeEach (to, from, next)!~>
  if BACK
    BACK := false
  else
    {path} = to
    len = HISTORY.length
    if HISTORY[len-1] != path
      HISTORY.push path
      if len > 99
        HISTORY.shift!
  next()

R.back = ~>
  BACK := true
  if HISTORY.length
    HISTORY.pop()
  if HISTORY.length
    url = HISTORY.pop()
  else
    url = \/
  R.push url

R.add = !~>
  R.addRoutes add.apply(void,arguments)

