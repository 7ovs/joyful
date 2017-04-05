# g_updateTimers = ( () ->
#   _.templateSettings.interpolate = /{{([\s\S]+?)}}/g
#   coundownTemplate = _.template("[ {{ days }} : {{ hours }} : {{ minutes }} : {{ seconds }} ]")
#   units = countdown.DAYS | countdown.HOURS | countdown.MINUTES | countdown.SECONDS
#   pad = (n) -> return if n < 10 then ("0" + n) else (n + "")
#   return () ->
#     ts = countdown(window.g_currentEventDate, null, units, 40, 0)
#     cd = 
#       days: ts.days
#       hours:   pad(ts.hours)
#       minutes: pad(ts.minutes)
#       seconds: pad(ts.seconds)
#     $(".countdown-view").html(coundownTemplate(cd))
# )()

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


# eventDates = 
#   poland:
#     warsaw: moment("").toDate
#     belastok:
#   germany:
#     berlin:
#   france:
#     paris:


$ () ->
  switchof = setInterval(g_updateTimers, 1000)


  # $('#country-tab > li').click ->
  #   $@ = $(@)
  #   date = $("##{$@.data().target} > li").first().data().date
  #   console.log date

  # $('#country-tab > li').click ->
  #   $@ = $(@)
  #   date = $("##{$@.data().target} > li").first().data().date
  #   console.log date

  # ->
  #   g_country = $(this).data().country


  # $(".uk-nav>li").on 'click', (event) ->
  #   console.log $(this).data().date
  #   if $(this).data().date
  #     window.g_currentEventDate = moment($(this).data().date).toDate()
  #   g_updateTimers()
  # $('[data-uk-switcher]').on 'show.uk.switcher', (event, area) ->
  #     console.log area.data().date
  #     $@ = $(@)

  #     g_updateTimers()