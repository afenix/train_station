class Line

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
  end

  define_singleton_method(:all) do
    returned_lines = DB.exec("SELECT * FROM lines;")
    lines = []
    returned_lines.each() do |line|
      name = line.fetch("name")
      id = line.fetch("id").to_i()
      lines.push(Line.new({:id => id, :name => name}))
    end
    lines
  end

  define_method(:save) do
    duplicate = false
    Line.all().each() do |name_check|
      if self.name().==(name_check.name())
        duplicate = true
      end
    end

    if duplicate == false
      result = DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

  end

  define_method(:==) do |other_line|
    self.name().==(other_line.name()) && self.id().==(other_line.id())
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM lines *;")
  end

  define_singleton_method(:find) do |line_id|
    found_line = nil
    Line.all().each() do |line|
      if line.id().==(line_id)
        found_line = line
      end
    end
    found_line
  end

  define_method(:join) do |station|
    number = DB.exec("INSERT INTO join_table (station_id, line_id) VALUES (#{station.id()}, #{@id}) RETURNING id;")
    join_id = number.first().fetch("id").to_i()
    join_id.instance_of?(Fixnum)
  end

  define_method(:list_station_names) do
    station_ids = []
    station_names = []
    returned_stations = DB.exec("SELECT * FROM join_table WHERE line_id = #{self.id()};")
    returned_stations.each() do |station|
      id = station.fetch("station_id").to_i()
      station_ids.push(id)
    end

    station_ids.each() do |id|
      station = DB.exec("SELECT * FROM stations WHERE id = #{id}")
      name = station.first().fetch("name")
      station_names.push(name)
    end
    station_names
  end


end
