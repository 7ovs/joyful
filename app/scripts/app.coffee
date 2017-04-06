g_updateTimers = ( () ->
  _.templateSettings.interpolate = /{{([\s\S]+?)}}/g
  coundownTemplate = _.template("[ {{ days }} : {{ hours }} : {{ minutes }} : {{ seconds }} ]")
  units = countdown.DAYS | countdown.HOURS | countdown.MINUTES | countdown.SECONDS
  pad = (n) -> return if n < 10 then ("0" + n) else (n + "")

  return () ->
    $(".countdown-view").each (index, el) ->
      $el = $(el)
      date = $(el).data().date;
      ts = countdown(moment(date).toDate(), null, units, 40, 0)
      cd = 
        days:    ts.days
        hours:   pad(ts.hours)
        minutes: pad(ts.minutes)
        seconds: pad(ts.seconds)
      $el.html(coundownTemplate(cd))
      
)()

$ () ->
  switchof = setInterval(g_updateTimers, 1000)