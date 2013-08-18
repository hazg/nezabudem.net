$('li > a').each () ->
  if window.location.pathname == $(this).attr('href')
    $(this).parent().addClass('active')
