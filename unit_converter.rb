require 'rspec/autorun'

#UnitConverter exercise - Create a unit converter using TDD
#UnitConverter.new.convert(5, :cup, :liter) #=> 1.183
#UnitConverter.new.convert(5, :cup, :gram) #=> DimensionMissmatchError!

DimensionMissmatchError = Class.new(StandardError)

Quantity = Struct.new(:amount, :unit) #Struct = Ruby class take number of arguments and provide getter and setter

class UnitConverter
  def initialize(initial_quantity, target_unit)
    @initial_quantity = initial_quantity
    @target_unit = target_unit
  end

  def convert
    Quantity.new(@initial_quantity.amount * conversion_factor(from: @initial_quantity.unit, to: @target_unit), @target_unit)
  end
end

private

#NO need to test private method, cuz user can't call it
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
      cups = Quantity.new(5, :cup)
      converter = UnitConverter.new(cups, :liter)

      result = converter.convert

      expect(result.amount).to be_within(0.001).of(1.183)
      expect(result.unit).to eq(:liter)
    end

    it "raises an error if the two units are of different dimensions" do
      cups = Quantity.new(5, :cup)
      converter = UnitConverter.new(cups, :gram)

      # pass in a { block }to raise an error
      expect { converter.convert }.to raise_error(DimensionMissmatchError)
    end
  end
end
