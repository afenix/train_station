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
end
