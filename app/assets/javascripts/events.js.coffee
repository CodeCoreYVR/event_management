# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require social-share-button
$ ->
  countdown = ()->
    # timeZoneOffset = (new Date().getTimezoneOffset())*60000
    curTime = new Date().getTime() #- timeZoneOffset
    $dates.each ->
      console.log("FEFE")
      eventTime = Date.parse($(@).data('date'))
      remaining = eventTime - curTime
      unit = "seconds"
      remaining /=(1000)
      if (remaining<0)
        $(this).text("Past Event")
      else
        if (remaining > 86400)
          remaining /= 86400
          unit= "Days"
        else if (86400 > remaining >= 3600)
          remaining /= 3600
          unit = "Hours"
        else if (3600 > remaining  >= 60)
          remaining /= 60
          unit = "Minutes"
        remaining= parseInt(remaining)
        $(this).text("In "+remaining+" "+unit)
  $dates = $(".jquery-dates")
  countdown()
  setInterval countdown,1000