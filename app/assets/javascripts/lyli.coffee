
show_lyli_form = (e) ->
  e.preventDefault()
  
  # Reset form
  form = $('#lyli-form')
  form.find('.response').hide()
  form.find('.rest').show()
  
  $('#lyli-form').show()
  
close_lyli_form = (e) ->
  e.preventDefault()
  $('#lyli-form').hide()

lyli_submit = (e) ->
  e.preventDefault()
  name_field = $('#lyli-name-field')
  data = {
    url: window.location.href
  }
  if !!name_field.val() # Is name_field not empty
    data.name = name_field.val()
  $.ajax {
    url: 'http://api.lyli.fi',
    type: 'POST',
    data: JSON.stringify(data),
    contentType: 'application/json; charset=utf-8',
    dataType: 'json',
    success: (data) ->
      # Request successful
      lyli_success = $('#lyli-success')
      anchor = lyli_success.find('a')
      anchor.text data['short-url'].replace('http://', '')
      anchor.attr 'href', data['short-url']
      $('#lyli-form .rest').hide()
      lyli_success.show()
    error: (data) ->
      if 'error' of data
        # Request errored
        $('#lyli-form .rest').hide()
        $('#lyli-error').show()
  }
  
  

ready = ->
  # Set hooks
  $('a#lyli').click show_lyli_form
  form = $('#lyli-form')
  form.submit lyli_submit
  form.find('.close a').click close_lyli_form
    
$(document).ready(ready)
# For turbolinks
$(document).on('page:load', ready)
