
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
  setInterval triviaCycle, 4000
  
$(document).ready ->
  triviaInit()
