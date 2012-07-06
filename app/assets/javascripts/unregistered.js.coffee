window.for_members = for_members = ()->
  $('#registration-frame').load '/users/sign_up', () ->
    $('#registration-frame > h2').hide()
    $('.registration.modal').modal()

$('.for-members').click () -> for_members()
