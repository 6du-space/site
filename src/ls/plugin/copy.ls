
$('body').on 'copy', (event) !->

  clipboardData = event.clipboardData or window.clipboardData
  select = window.getSelection!.toString!.trim!

  if (not clipboardData) or select.length < 42
    return

  suffix = "\n\n" + '来源 : ' + document.title + ' ' + window.location.href + '\n'

  clipboardData
    ..setData('text/html', select+suffix.replace(/\n/g,'<br>'))
    ..setData('text/plain', select+suffix)

  return false
