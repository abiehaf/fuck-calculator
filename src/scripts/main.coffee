
startCounting = ->
  currentProgress = 0
  done = false



  interval = setInterval ->
    currentProgress += Math.random() * 2
    if currentProgress > 100
      currentProgress = 99.999
      done = true
    $('#progress-percent').html(Math.round(currentProgress) + "%")

    deg = currentProgress / 50 * Math.PI
    y = 250 - 240 * Math.cos(deg)
    x = 250 + 240 * Math.sin(deg)
    f = if currentProgress > 50 then 1 else 0
    r = Math.round(230 - currentProgress * 1.5)
    g = Math.round(80 + currentProgress * 0.8)
    $('#circle-progress')
    .attr('d', "M 250 10 A 240 240 0 #{f} 1 #{x} #{y}")
    .attr('stroke', "rgb(#{r}, #{g}, 50)")

    if done
      clearInterval interval
      setTimeout ->
        $('#loading-section').fadeOut()
      , 1000
      setTimeout ->
        $('#result-section').fadeIn()
      , 1800
  , 300

$(document).ready ->
  $('#start-button').click ->
    $('#action-container').fadeOut()
    setTimeout ->
      $('#progress-container').fadeIn()
    , 500
    setTimeout ->
      startCounting()
    , 1000

