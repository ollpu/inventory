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

color_features = ->
  # Assign a semi-unique hue to every feature-span, based on its text (content)
  $('span.item_type.feature').each (i, el) ->
    me = $(el)
    content = me.html()
    me.css('background-color', "hsl(#{hue_from_string content}, 59%, 67%)")

select_all_items = (e) ->
  e.preventDefault()
  $('#list-items-form').submit()

ready = ->
  if window.location.hash is '#edit'
    edit_toggle() # Toggle edit mode on
  
  $('form.edit_item a#edit').click edit_toggle
  
  color_features()
  
  $('#list-items-form .submit').click select_all_items
  
$(document).ready(ready)
# For turbolinks
$(document).on('page:load', ready)
# For ajax requests (which might add new feature-spans)
$(document).ajaxComplete(color_features)
