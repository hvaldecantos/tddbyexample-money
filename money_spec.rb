require 'rspec/core'

class Dollar
  def initialize amount
    @amount = amount
  end

  def times multiplier
    Dollar.new @amount * multiplier
  end

  def == dollar
    @amount == dollar.amount
  end

  protected
    attr_reader :amount

end

RSpec.describe "Money" do
  it "can be multiplied" do
    five = Dollar.new(5)
    expect(five.times(2)).to eq(Dollar.new 10)
    expect(five.times(3)).to eq(Dollar.new 15)
  end

  it "can be compared for equality" do
    expect(Dollar.new(5)).to eq(Dollar.new(5))
    expect(Dollar.new(5)).not_to eq(Dollar.new(6))
  end
end
