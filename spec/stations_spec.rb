require('spec_helper')

describe(Station) do
  describe(".all") do
    it("returns all stations - returns empty at first") do
      expect(Station.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("returns the name of the station") do
      test_name = Station.new({:id => 7, :name => "Red Station"})
      expect(test_name.name()).to(eq("Red Station"))
    end
  end

  describe("#id") do
    it("returns the id of the station") do
      test_name = Station.new({:id => 7, :name => "Red Station"})
      expect(test_name.id()).to(eq(7))
    end
  end

  describe("#save") do
    it("saves the station to the stations table") do
      test_save = Station.new({:name => "Red Station"})
      test_save.save()
      expect(Station.all()).to(eq([test_save]))
    end
  end

  describe("#save") do
    it("only saves if the station to be saved isn't already in the list") do
      test_1 = Station.new({:name => "Epicodus"})
      test_1.save()
      test_2 = Station.new({:name => "Epicodus"})
      test_2.save()
      expect(Station.all()).to(eq([test_1]))
    end
  end

  describe("#==") do
    it("treats two station with the same id and name as equal to each other") do
      test_1 = Station.new({:name => "Epicodus"})
      test_2 = Station.new({:name => "Epicodus"})
      expect(test_1).to(eq(test_2))
    end
  end

  describe(".clear") do
    it("clears the trains database of all stations in the stations table") do
      test_1 = Station.new({:name => "Epicodus"})
      test_1.save()
      test_2 = Station.new({:name => "Times Square"})
      test_2.save()
      Station.clear()
      expect(Station.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("finds a station based on a station_id") do
      test_1 = Station.new({:name => "Epicodus"})
      test_1.save()
      test_2 = Station.new({:name => "Times Square"})
      test_2.save()
      expect(Station.find(test_1.id())).to(eq(test_1))
    end
  end

  describe("#join") do
    it("copies the unique station id and unique station id in the join table") do
      test_line = Line.new({:name => "Red Line"})
      test_line.save()
      test_station = Station.new({:name => "Epicodus"})
      test_station.save()
      expect(test_station.join(test_line)).to(eq(true))
    end
  end
end
