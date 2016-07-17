require 'rspec/autorun'

#UnitConverter exercise - Create a unit converter using TDD
#UnitConverter.new.convert(5, :cup, :liter) #=> 1.183
#UnitConverter.new.convert(5, :cup, :gram) #=> DimensionMissmatchError!

describe "UnitConverter" do
  describe "#convert" do
    it "translates between objects of same dismension" do
      converter = UnitConverter.new(5, :cup, :liter)

      expect(converter.convert).to be_within(0.001).of(1.183)
    end

    it "raises an error if the two units are of different dimensions" do
      converter = UnitConverter.new(5, :cup, :gram)

      # pass in a { block }to raise an error
      expect { converter.convert }.to raise_error(DimensionMissmatchError)
    end
  end

end
