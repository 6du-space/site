(async ()=>{
  //await navigator.serviceWorker.register('/sw.js', {scope: '/'});
  var tag=(tag,attr)=>{
    var sc = document.createElement(tag);
      for(i in attr){
        sc.setAttribute(i, attr[i]);
      }
      document.head.appendChild(sc)

  }
  // 请替换为自己的腾讯统计
  // tag('script',{
  //   src:'//tajs.qq.com/stats?sId=66475325',
  //   async:true
  // })
  let html = await(await fetch('/site.html')).text();
  for(var i of html.split("<")){
    if(i.indexOf('rel="prefetch"')<0){
      let src=i.split('"')[1]
      if(src){
        if(src.endsWith('.js')){
          tag('script', {src})
        }
        else{
          tag('link', {
            href:src,
            rel:"stylesheet"
          })
        }
      }
    }
  }
})()

