require 'rspec/core'

class Money
  def == money
    @amount == money.amount && self.class == money.class
  end
  def self.dollar amount
    Dollar.new(amount)
  end
  protected
    attr_reader :amount

end

class Franc < Money
  def initialize amount
    @amount = amount
  end

  def times multiplier
    Franc.new @amount * multiplier
  end
end

class Dollar < Money
  def initialize amount
    @amount = amount
  end

  def times multiplier
    Dollar.new @amount * multiplier
  end
end

RSpec.describe "Money" do
  it "can be multiplied" do
    five = Money.dollar(5)
    expect(five.times(2)).to eq(Dollar.new 10)
    expect(five.times(3)).to eq(Dollar.new 15)
  end

  it "can be compared for equality" do
    expect(Money.dollar(5)).to eq(Money.dollar(5))
    expect(Money.dollar(5)).not_to eq(Money.dollar(6))
    expect(Franc.new(5)).to eq(Franc.new(5))
    expect(Franc.new(5)).not_to eq(Franc.new(6))
    expect(Franc.new(5)).not_to eq(Money.dollar(5))
  end

  it "(Franc) can be multiplied" do
    five = Franc.new(5)
    expect(five.times(2)).to eq(Franc.new 10)
    expect(five.times(3)).to eq(Franc.new 15)
  end
end
