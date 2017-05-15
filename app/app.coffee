express = require "express"
ect = require "ect"
fs = require "fs"
moment = require "moment"
_ = require "lodash"
request = require "request"


String.prototype.capitalizeFirstLetter = () ->
  @charAt(0).toUpperCase() + this.slice(1)


data = JSON.parse(fs.readFileSync("data.json", 'utf-8'))
moment.locale('ru')

data.ru.trip_panel.trip = data.ru.trip_panel.trip.map (country) ->
  country.concerts = country.concerts.map (conc) ->
    conc.dateFormat1 = moment(conc.date).format(data.ru.date_format)
    conc.dateFormat1 = conc.dateFormat1.capitalizeFirstLetter()
    return conc
  return country

moment.locale('fr')

data.fr = _.extend({}, data.ru, data.fr)

data.fr.trip_panel.trip = data.fr.trip_panel.trip.map (country) ->
  country.concerts = country.concerts.map (conc) ->
    conc.dateFormat1 = moment(conc.date).format(data.fr.date_format)
    conc.dateFormat1 = conc.dateFormat1.capitalizeFirstLetter()
    return conc
  return country

moment.locale('pl')
data.pl = _.extend({}, data.ru, data.pl)

app = express()

app
  .disable("x-powered-by")
  .set("view engine", "ect")
  .engine('ect', ect(
      root : __dirname + '/views'
      ext : '.ect'
      cache: no
    ).render)
  
app.get '/', (req, res) ->
  res.redirect "/ru"

app.get '/ru', (req, res) ->
  res.render 'index', data.ru

app.get '/fr', (req, res) ->
  res.render 'index', data.fr

app.use(express.static("pub"))

app.use (req, res, next) ->
  res.status 404
  if req.accepts('html')
    res.render '404', url: req.url
  if req.accepts('json')
    res.send error: 'Not found'
  res.type('txt').send 'Not found'

app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render '500', error: err

port = process.env.PORT || 3000
app.listen(port)
console.log "start server on port #{port}"