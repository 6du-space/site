export default _ = (url)~>
  arguments[0] = url+'.'+url.slice(0,url.indexOf("/"))
  $get.apply @, arguments
