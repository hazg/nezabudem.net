$('a.profile').each ()->
  $this = $(this)
  name  = window.nut.random_string()
  id    = parseInt($this.attr('rel'))
  private_message = ''
  $this.wrap("<div class='dropdown' id='#{name}'>")
  
  if id != window.current_user
    private_message = "<li><a class='private-message' rel='#{id}' href='#'><i class='icon-envelope'></i>Новое личное сообщение</a></li>"

  $this.after($("
    <ul class='dropdown-menu'>
      <li><a href='#{$this.attr('href')}'><i class='icon-user'></i>Перейти к профилю</a></li>
      #{private_message}    
    </ul>"
  ))
  $this.attr('href', name)
.addClass('dropdown-toggle')

$('.private-message').click () ->
  $this = $(this)
  $('#private-message-frame').load "/messages/new?to=#{$this.attr('rel')}", () ->
    $('#private-message-frame ul.nav.nav-tabs').hide()
  $('.private-message.modal').modal()
$(document).ready () ->
  $('.blink').blink()