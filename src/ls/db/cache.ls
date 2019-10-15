import
  \idb : {openDB}

var DB
open = ~>
  if not DB
    DB := await openDB(
      \cache
      1
      * upgrade: (db)!~>
          for i in <[
            hash
            url
          ]>
            db.createObjectStore(i, { keyPath: \k })
    )
  return DB

_opened = (func) ~>
  ~>
    await open!
    func.apply(DB, arguments)

opened = (obj)~>
  for k,v of obj
    if typeof(v) == \function
      obj[k] = _opened(v)
    else
      obj[k] = opened(v)
  obj

export default _ = opened {
  set :
    url-hash : (url, hash, txt)->
      tx = @transaction(
        <[
          url
          hash
        ]>
        \readwrite
      )
      tx.objectStore(\url).put {
        k:url
        v:hash
      }
      tx.objectStore(\hash).put {
        k:hash
        v:txt
      }
      await tx.done
  get:
    url : (url)->

    hash : (hash)->
      await @get(\hash, hash)
}
