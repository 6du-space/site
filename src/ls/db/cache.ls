import
  \idb : {openDB}

var DB
export default _ = ~>
  if not DB
    DB := await openDB(
      \cache
      1
      * upgrade: (db)!~>
          db.createObjectStore(\hash, { keyPath: \k })
          db.createObjectStore(\url, { keyPath: \k })
    )
  return DB
