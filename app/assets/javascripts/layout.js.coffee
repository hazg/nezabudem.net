$ () ->
  hide_alerts = () ->
    jQuery('div.alert').fadeOut('fast')
  setTimeout hide_alerts, 5000
  jQuery('div.alert').click (e)->
    jQuery(e.target).hide()

