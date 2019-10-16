(async ()=>{
  var elem=(tag,attr)=>{
    var sc = document.createElement(tag);
      for(i in attr){
        sc.setAttribute(i, attr[i]);
      }
      document.head.appendChild(sc)

  }
  let html = await(await fetch('/site.html')).text();
  for(var i of html.split("<")){
    if(i.indexOf('rel="prefetch"')<0){
      let src=i.split('"')[1]
      if(src){
        if(src.endsWith('.js')){
          elem('script', {src})
        }
        else{
          elem('link', {
            href:src,
            rel:"stylesheet"
          })
        }
      }
    }
  }
})()

