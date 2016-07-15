require "rspec/autorun"

class Calculator
  def add(x, y)
    x+y
  end

  def factorial(x)
    if x == 0
      return 1
    else
      (1..x).reduce(:*)
    end
  end
end

describe Calculator do
  describe "#add" do
    it "returns the sum of two arguments" do
      calculator = Calculator.new

      expect(calculator.add(10,25)).to eq(35)
    end

    it "returns the sum of two different arguments" do
      calculator = Calculator.new

      expect(calculator.add(182,18)).to eq(200)
    end
  end

  describe "#factorial" do
    it "returns 1 when given 0" do
      calculator = Calculator.new

      expect(calculator.factorial(0)).to eq(1)
    end

    it "should return 5040 when given 7" do
      calculator = Calculator.new

      expect(calculator.factorial(7)).to eq(5040)
    end
  end
end
