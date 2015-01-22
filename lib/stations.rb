class Station

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
  end

  define_singleton_method(:all) do
    returned_stations = DB.exec("SELECT * FROM stations;")
    stations = []
    returned_stations.each() do |station|
      name = station.fetch("name")
      id = station.fetch("id").to_i()
      stations.push(Station.new({:id => id, :name => name}))
    end
    stations
  end

  define_method(:save) do
    duplicate = false
    Station.all().each() do |name_check|
      if self.name().==(name_check.name())
        duplicate = true
      end
    end

    if duplicate == false
      result = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

  end

  define_method(:==) do |other_station|
    self.name().==(other_station.name()) && self.id().==(other_station.id())
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM stations *;")
  end

  define_singleton_method(:find) do |station_id|
    found_station = nil
    Station.all().each() do |station|
      if station.id().==(station_id)
        found_station = station
      end
    end
    found_station
  end

  define_method(:join) do |line|
    number = DB.exec("INSERT INTO join_table (line_id, station_id) VALUES (#{line.id()}, #{@id}) RETURNING id;")
    join_id = number.first().fetch("id").to_i()
    join_id.instance_of?(Fixnum)
  end
end
