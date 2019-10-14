export default _ = (url)~>
  $get(
    url+'.'+url.slice(0,url.indexOf("/"))
  )
