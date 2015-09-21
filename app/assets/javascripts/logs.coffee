# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).ready ->
#   # Add affected item list field submit button
#   $('#add-item-by-uid-button').click ->
#     # Parameters for ajax request
#     data = 'uid=' + $('#add-item-by-uid-field').val()
#     $.ajax(url: 'add_affected_item', data: data).done (html) ->
#       # Hide error text (and store its reference in a variable)
#       error = $('span.add-item-error-container').hide()
#       if !!html
#         $('#affected-items').append html
#         $('span.affects-nothing').hide()
#         $('div.item-minidisplay.newly-added')
#           .fadeIn(duration: 400)
#           .removeClass('newly-added')
#         $('#add-item-by-uid-field').val('')
#       else
#         # Request returned nothing, display error
#         error.show()
