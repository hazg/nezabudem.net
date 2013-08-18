# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

refresh_redactor = () ->
  $('div.comments_threads #comment_body').destroyEditor()
  $('div.comments_threads #comment_body').redactor
    lang: 'ru'
    path: window.redactor_path
    css: window.redactor_css

form = $('div.comments_threads #new_comment').addClass('span9')
$('div.comments_threads a.small.reply').click (e) =>
  reply = $(e.currentTarget)
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
