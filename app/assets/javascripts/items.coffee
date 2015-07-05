# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

edit_toggle = ->
  form = $('form.edit_item')
  edit_button = form.find('a#edit')
  form.toggleClass 'open'
  if form.hasClass 'open'
    $(edit_button).html 'close'
    window.location.hash = '#edit'
  else
    $(edit_button).html 'edit'
    window.location.hash = ''

ready = ->
  if window.location.hash is '#edit'
    edit_toggle() # Toggle edit mode on
  
  $('form.edit_item a#edit').click edit_toggle
    
$(document).ready(ready)
# For turbolinks
$(document).on('page:load', ready)
