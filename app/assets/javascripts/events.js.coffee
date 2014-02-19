# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require social-share-button
$ ->
  countdown = ()->
    # timeZoneOffset = (new Date().getTimezoneOffset())*60000
    curTime = new Date().getTime() #- timeZoneOffset
    $dates.each ->
      eventTime = Date.parse($(@).data('date'))
      if eventTime!=eventTime
        eventTime = Date.parse($(@).data('secdate'))
      timeRemaining = eventTime - curTime
      firUnit = "seconds"
      timeRemaining /=(1000)
      firRemaining = timeRemaining
      secRemaining = 0
      secUnit= ""
      if (firRemaining<0)
        $(this).text("Past Event")
      else
        if (timeRemaining > 86400)
          firRemaining /= 86400
          firUnit = "Days"
          secRemaining = (timeRemaining%86400)/3600
          if secRemaining >= 1
            secUnit = "Hours"
        else if (86400 > timeRemaining >= 3600)
          firRemaining /= 3600
          firUnit = "Hours"
          secRemaining = (timeRemaining%3600)/60
          if secRemaining >= 1
            secUnit = "Minutes"
        else if (3600 > timeRemaining  >= 60)
          firRemaining /= 60
          firUnit = "Minutes"
          secRemaining = (timeRemaining%60)
          if secRemaining >= 1
            secUnit = "Seconds"
        firRemaining= parseInt(firRemaining)
        secRemaining= parseInt(secRemaining)
        secPart= ''
        if secRemaining>0
          secPart= " and "+secRemaining+" "+secUnit
        if (firRemaining==firRemaining)
          $(this).text("In "+firRemaining+" "+firUnit+secPart)
  $dates = $(".jquery-dates")
  countdown()
  setInterval countdown,1000