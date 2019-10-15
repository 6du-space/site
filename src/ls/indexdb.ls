
export default _ = (name, version, init)~>
  new Promise(
    (resolve, reject)!~>
      conn = indexedDB.open(
        name, version
      )

      conn.onsuccess = (event) !~>
        resolve event.target.result

      conn.onupgradeneeded = (event) !~>
        init(event.target.result)

      request.onerror = reject
  )
