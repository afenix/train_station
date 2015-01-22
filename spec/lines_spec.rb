require('spec_helper')

describe(Line) do
  describe(".all") do
    it("returns all lines - returns empty at first") do
      expect(Line.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("returns the name of the line") do
      test_name = Line.new({:id => 7, :name => "Red Line"})
      expect(test_name.name()).to(eq("Red Line"))
    end
  end

  describe("#id") do
    it("returns the id of the line") do
      test_name = Line.new({:id => 7, :name => "Red Line"})
      expect(test_name.id()).to(eq(7))
    end
  end

  describe("#save") do
    it("saves the line to the lines table") do
      test_save = Line.new({:name => "Red Line"})
      test_save.save()
      expect(Line.all()).to(eq([test_save]))
    end
  end

  describe("#save") do
    it("only saves if the line to be saved isn't already in the list") do
      test_1 = Line.new({:name => "Red Line"})
      test_1.save()
      test_2 = Line.new({:name => "Red Line"})
      test_2.save()
      expect(Line.all()).to(eq([test_1]))
    end
  end

  describe("#==") do
    it("treats two line with the same id and name as equal to each other") do
      test_1 = Line.new({:name => "Red Line"})
      test_2 = Line.new({:name => "Red Line"})
      expect(test_1).to(eq(test_2))
    end
  end

  describe(".clear") do
    it("clears the trains database of all lines in the lines table") do
      test_1 = Line.new({:name => "Red Line"})
      test_1.save()
      test_2 = Line.new({:name => "Blue Line"})
      test_2.save()
      Line.clear()
      expect(Line.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("finds a line based on a line_id") do
      test_1 = Line.new({:name => "Red Line"})
      test_1.save()
      test_2 = Line.new({:name => "Blue Line"})
      test_2.save()
      expect(Line.find(test_1.id())).to(eq(test_1))
    end
  end

  describe("#join") do
    it("copies the unique line id and unique station id in the join table") do
      test_line = Line.new({:name => "Red Line"})
      test_line.save()
      test_station = Station.new({:name => "Epicodus"})
      test_station.save()
      expect(test_line.join(test_station)).to(eq(true))
    end
  end

  describe("#list_station_names") do
    it("will return all the stations associated with a particular line") do
      test_line = Line.new({:name => "Red Line"})
      test_line.save()
      test_station = Station.new({:name => "Epicodus"})
      test_station.save()
      test_line.join(test_station)
      test_station2 = Station.new({:name => "Times Square"})
      test_station2.save()
      test_line.join(test_station2)
      test_station3 = Station.new({:name => "Guam"})
      test_station3.save()
      test_line.join(test_station3)
      expect(test_line.list_stations()).to(eq(["Epicodus", "Times Square", "Guam"]))
    end
  end

end
