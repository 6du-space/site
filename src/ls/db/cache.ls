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


rm = (dict)!~>
  tx = DB.transaction(Object.keys(dict), \readwrite)
  for k,v of dict
    tx.objectStore(k).delete(\k , v)
  return tx.done


put = (dict)!~>
  tx = DB.transaction(Object.keys(dict), \readwrite)
  for k,v of dict
    tx.objectStore(k).put {
      k:v.shift!
      v:if v.length == 1 then v[0] else v
    }
  return tx.done


save = (url, hash, txt)~>
  old-hash = await DB.get \url, url
  if old-hash
    await rm {
      li: old-hash
      hash: old-hash
    }
    #TODO 检测缓存，删除过期

  [h1, brief, meta] = md-load txt
  h1 = meta.链接标题 or h1
  brief = md brief
  li = [hash,meta.作者 or 0, h1, brief]
  await put {
    url : [url, hash]
    hash : [hash, txt]
    li
  }
  return li

export

  by-url = opened (url)->
    hash = await @get \url, url
    if hash
      r = await @get \hash, hash.v
      if r
        return r.v
    v = await $f url, \arrayBuffer
    hash = await crypto.subtle.digest(\SHA-256, v)
    txt = new TextDecoder(\utf-8).decode v
    v = await save url, hash, txt
    return txt

  li-get = opened (url, hash)->
    r = (await @get(\li, hash))
    if r
      v = r.v
    else
      v = await save url, hash, await $f url
    return v

