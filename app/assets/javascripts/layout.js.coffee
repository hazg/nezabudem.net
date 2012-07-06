hide_alerts = () ->
  $('div.alert').fadeOut('fast')
setTimeout hide_alerts, 5000
$('div.alert').click (e)->
  $(e.target).hide()
  

