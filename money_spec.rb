require 'rspec/core'

class Money
  def initialize amount, currency
    @amount = amount
    @currency = currency
  end
  def == money
    @amount == money.amount && self.class == money.class
  end
  def self.dollar amount
    Dollar.new(amount, "USD")
  end
  def self.franc amount
    Franc.new(amount, "CHF")
  end
  def currency
    @currency
  end
  protected
    attr_reader :amount
end

class Franc < Money
  def times multiplier
    Money.franc @amount * multiplier
  end
end

class Dollar < Money
  def times multiplier
    Money.dollar @amount * multiplier
  end
end

RSpec.describe "Money" do
  it "can be multiplied" do
    five = Money.dollar(5)
    expect(five.times(2)).to eq(Money.dollar 10)
    expect(five.times(3)).to eq(Money.dollar 15)
  end

  it "can be compared for equality" do
    expect(Money.dollar(5)).to eq(Money.dollar(5))
    expect(Money.dollar(5)).not_to eq(Money.dollar(6))
    expect(Money.franc(5)).to eq(Money.franc(5))
    expect(Money.franc(5)).not_to eq(Money.franc(6))
    expect(Money.franc(5)).not_to eq(Money.dollar(5))
  end

  it "(Franc) can be multiplied" do
    five = Money.franc(5)
    expect(five.times(2)).to eq(Money.franc 10)
    expect(five.times(3)).to eq(Money.franc 15)
  end

  it "is possible to get the currency string" do
    expect("USD").to eq(Money.dollar(1).currency)
    expect("CHF").to eq(Money.franc(1).currency)
  end
end
