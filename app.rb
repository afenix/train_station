require('sinatra')
require('sinatra/reloader')
also_reload('./lib/**/*.rb')
require('./lib/lines')
require('./lib/stations')
require('pry')
require('pg')

DB = PG.connect({:dbname => 'trains'})

get("/") do
  erb(:index)
end

get("/operator") do
  @lines = Line.all()
  @stations = Station.all()
  erb(:operator)
end

get("/rider") do
  @lines = Line.all()
  @stations = Station.all()
  erb(:line)
end

get("/line/:line_id") do
  @found_line = Line.find(params.fetch("line_id").to_i())
  @line_station_names = @found_line.list_station_names()
  erb(:station)
end

post("/add") do
  line_name = params.fetch("line")
  station_name = params.fetch("station")
  line = Line.new({:name => line_name})
  line.save()
  station = Station.new({:name => station_name})
  station.save()
  line.join(station)

  redirect("/operator")
end
