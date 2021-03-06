
setIntervalTurbolinks = (targetFunction, millis) ->
  removeInterval = ->
    clearInterval intervalId
    $(document).off('page:load', removeInterval);
    
  intervalId = setInterval(targetFunction, millis)
  $(document).on('page:load', removeInterval)


triviaCycle = ->
  trivia = $('ul.trivia')
  pointer = trivia.data('pointer')
  items = trivia.find('li')
  length = items.length
  
  items.fadeOut(400)
  items.promise().done ->
    items.eq(pointer).fadeIn(400)
  
  pointer = if pointer < length-1 then pointer + 1 else 0
  
  trivia.data('pointer', pointer)

triviaInit = ->
  trivia = $('ul.trivia')
  items = trivia.find('li')
  
  items.hide()
  items.eq(0).show()
  trivia.css('display', 'inline-block')
  
  triviaCycle()
  setIntervalTurbolinks triviaCycle, 4000
  
  

  
ready = ->
  triviaInit()
  $('#navigation .menu-btn a').click (e) ->
    e.preventDefault()
    $('#navigation .items, #navigation .search').toggleClass('isOpen')
    
$(document).ready(ready)
# For turbolinks
$(document).on('page:load', ready)
