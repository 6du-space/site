export default _ = (url,suffix)~>
  $get(
    url+'.'+(suffix or url.slice(0,url.indexOf("/")))
  )
