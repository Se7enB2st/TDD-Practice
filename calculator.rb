require "rspec/autorun"



describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new

      expect(calculator.add(10,25)).to eq(35)
    end
  end
end
