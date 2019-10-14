require('./init.styl')

import
  \./src.ls : spin

n = 0
t = 0
export default _ = {
  inc: !~>
    if not n
      t := setTimeout(
          ->
            spin.start()
          300
      )
    n := n+1

  done: !~>
    n := n-1
    if not n
      clearTimeout t
      spin.done()
    if n < 0
      n := 0
}

