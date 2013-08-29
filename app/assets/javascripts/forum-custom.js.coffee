b1 = $('ul.breadcrumb')
b2 = $('h2:first').hide()
$('a', b2).each () ->
  $(this).wrap('<li>').after($('<span class="divider">/</div>'))
  b1.append($('li', b2))
$('menu').addClass('btn-group')
$('menu > a, div.contents > ul.actions > li > a').addClass('btn').each () ->
  if /(Ответить)|(Новая тема)/.test $(this).text()
    $(this).addClass('btn-danger').prepend('<i class="icon-share-alt icon-white">').css('color', 'white')
  $(this).prepend('<i class="icon-remove">') if /Удалить/.test $(this).text()
  $(this).prepend('<i class="icon-ok-circle">') if /Подписаться/.test $(this).text()
  $(this).prepend('<i class="icon-ban-circle">') if /Отписаться/.test $(this).text()
$('div.contents > ul.actions').addClass('nav nav-tabs nav-stacked')
