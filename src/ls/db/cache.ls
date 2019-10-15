import
  \@/ls/html/md-load
  \@/ls/html/md
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
            li
          ]>
            db.createObjectStore(i, { keyPath: \k })
    )
  return DB

opened = (func) ~>
  ~>
    await open!
    func.apply(DB, arguments)


put = (dict)!~>
  tx = DB.transaction(Object.keys(dict), \readwrite)
  for k,v of dict
    tx.objectStore(k).put {
      k:v.shift!
      v:if v.length == 1 then v[0] else v
    }
  return tx.done


save = (url, hash, txt)~>
  [h1, brief, meta] = md-load txt
  h1 = meta.链接标题 or h1
  brief = md brief
  li = [hash, h1, brief]
  await put {
    url : [url, hash]
    hash : [hash, txt]
    li
  }
  return li

export

  by-url = opened (url)->

  li-get = opened (url, hash)->
    r = (await @get(\li, hash))
    if r
      v = r.v
    else
      #TODO 检测缓存，删除过期
      v = await save url, hash, await $f url
    v.push url
    return v

