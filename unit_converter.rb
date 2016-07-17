require 'rspec/autorun'

#UnitConverter exercise - Create a unit converter using TDD
#UnitConverter.new.convert(5, :cup, :liter) #=> 1.183
#UnitConverter.new.convert(5, :cup, :gram) #=> DimensionMissmatchError!

DimensionMissmatchError = Class.new(StandardError)

class UnitConverter
  def initialize(initial_amount, initial_unit, target_unit)
    @initial_amount = initial_amount
    @initial_unit = initial_unit
    @target_unit = target_unit
  end

  def convert
    @initial_amount * conversion_factor(from: @initial_unit, to: @target_unit)
  end
end

private

CONVERSION_FACTOR = {
  cup: {
    liter: 0.236588
  }
}

def conversion_factor(from:, to:)
  CONVERSION_FACTOR[from][to] || raise(DimensionMissmatchError,"Cant convert from #{from} to #{to}!" )
end


#TESTS:

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
