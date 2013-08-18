$('.form-radio').each () ->
  $this = $(this)
  target = $($this.attr('rel'))
  $this.click (e) =>
    active = $(e.target)
    target.val(active.val())
  $(".btn[value='#{target.val()}']", $this).addClass('active')
