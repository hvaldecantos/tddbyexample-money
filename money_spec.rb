require 'rspec/core'

class Money
  def initialize amount, currency
    @amount = amount
    @currency = currency
  end
  def == money
    @amount == money.amount && self.currency == money.currency
  end
  def self.dollar amount
    Money.new(amount, "USD")
  end
  def self.franc amount
    Money.new(amount, "CHF")
  end
  def times multiplier
    Money.new @amount * multiplier, @currency
  end
  def currency
    @currency
  end
  protected
    attr_reader :amount
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
    expect(Money.franc(5)).not_to eq(Money.dollar(5))
  end

  it "is possible to get the currency string" do
    expect("USD").to eq(Money.dollar(1).currency)
    expect("CHF").to eq(Money.franc(1).currency)
  end
end
