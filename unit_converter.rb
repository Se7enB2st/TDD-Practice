require 'rspec/autorun'

#UnitConverter exercise from Thoughtbot Upcase
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


  private

  # NO need to test private method, cuz user can't call it
  CONVERSION_FACTORS = {
    liter: {
      liter: 1,
      cup: 4.226775,
      pint: 2.11338
    },
    gram: {
      gram: 1,
      kilgram: 1000
    }
  }

  # If common unit is found then convert the unit
  # else return DimensionMissmatchError
  def conversion_factor(from:, to:)
    dimension = common_dimension(from, to)
    if !dimension.nil?
      CONVERSION_FACTORS[dimension][to] / CONVERSION_FACTORS[dimension][from]
    else
      raise(DimensionMissmatchError, "Cant convert from #{from} to #{to}!" )
    end
  end
  
  # Find the common dimension between 2 units
  # Search through CONVERSION FACTORS and find the common unit(key) that is included in both unit
  def common_dimension(from, to)
    CONVERSION_FACTORS.keys.find do |canonical_unit|
      CONVERSION_FACTORS[canonical_unit].keys.include?(from) && CONVERSION_FACTORS[canonical_unit].keys.include?(to)
    end
  end
end


# TESTS:

describe "UnitConverter" do
  describe "#convert" do
    it "translates between objects of same dismension" do
      cups = Quantity.new(5, :cup)
      converter = UnitConverter.new(cups, :liter)

      result = converter.convert

      expect(result.amount).to be_within(0.001).of(1.183)
      expect(result.unit).to eq(:liter)
    end

    it "can convert between quantities of the same unit" do
      cups = Quantity.new(7, :cup)
      converter = UnitConverter.new(cups, :cup)

      result = converter.convert

      expect(result.amount).to be_within(0.001).of(7)
      expect(result.unit).to eq(:cup)
    end

    it "raises an error if the two units are of different dimensions" do
      cups = Quantity.new(5, :cup)
      converter = UnitConverter.new(cups, :gram)

      # pass in a { block }to raise an error
      expect { converter.convert }.to raise_error(DimensionMissmatchError)
    end
  end
end
