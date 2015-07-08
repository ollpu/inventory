# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Hashes a string into a 0-255 integer
hue_from_string = (string) ->
  string = string.toLowerCase()
  hue = 0
  for i in [0..string.length-1]
    char = string.charCodeAt(i)
    hue += char
  hue = hue %% 256
  hue

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
  
  # Assign a semi-unique hue to every feature-span, based on its text (content)
  $('div.items_show span.item_type.feature').each (i, el) ->
    me = $(el)
    content = me.data 'content'
    me.css('background-color', "hsl(#{hue_from_string content}, 59%, 67%)")
    
$(document).ready(ready)
# For turbolinks
$(document).on('page:load', ready)
