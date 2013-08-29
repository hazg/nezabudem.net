refresh_redactor = () ->
  $('[name=_wysihtml5_mode], .wysihtml5-sandbox, .wysihtml5-toolbar').remove()
  $('div.comments_threads #comment_body').show().wysihtml5
    locale: 'ru-RU'

form = $('div.comments_threads #new_comment').addClass('span9')

$('div.comments_threads a.small.reply').click (e) =>
  reply = $(e.currentTarget)
  console.log reply
  id    = reply.attr('rel')
  form.addClass('has-parent')
  $('#comment_parent_id', form).attr('value', reply.attr('rel'))
  reply.after(form)
  refresh_redactor()
  false

$('div.comments_threads i.icon-remove').click (e) =>
  reply = $(e.currentTarget)
  form.removeClass('has-parent')
  $('#comment_parent_id', form).attr('value', '')
  $('#reply-form-place').append(form)
  refresh_redactor()
  false
