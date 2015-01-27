require 'rspec/core'

class Dollar
  def initialize amount
    @amount = amount
  end

  def times multiplier
    Dollar.new @amount * multiplier
  end

  def amount
    @amount
  end

end

RSpec.describe "Money" do
  it "can be multiplied" do
    five = Dollar.new(5)
    product = five.times(2)
    expect(product.amount).to eq(10)
    product = five.times(3)
    expect(product.amount).to eq(15)
  end

  it "can be compared for equality" do
    expect(Dollar.new(5)).to eq(Dollar.new(5))
    expect(Dollar.new(5)).not_to eq(Dollar.new(6))
  end
end
