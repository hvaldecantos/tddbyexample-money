require 'rspec/core'

class Dollar
  def initialize amount
    @amount = amount
  end

  def times multiplier
    @amount *= multiplier
  end

  def amount
    @amount
  end
end

RSpec.describe "Money" do
  it "can be multiplied" do
    five = Dollar.new(5)
    five.times(2)
    expect(five.amount).to eq(10)
  end
end
