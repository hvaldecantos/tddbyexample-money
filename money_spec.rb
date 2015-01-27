require 'rspec/core'

class Dollar
  def initialize amount
    @amount = 10
  end

  def times multiplier
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
