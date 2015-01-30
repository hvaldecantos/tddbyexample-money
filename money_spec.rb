require 'rspec/core'

class Bank
  def reduce source, to
    Money.dollar(10)
  end
end

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
  def plus addend
    Money.new @amount + addend.amount, @currency
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

  it "can be added" do
    five = Money.dollar(5)
    sum = five.plus(five)
    bank = Bank.new
    reduced = bank.reduce(sum, "USD")
    expect(reduced).to eq(Money.dollar(10))
  end

  it "returns a Sum when adding" do
    five = Money.dollar(5)
    sum = five.plus(five)
    expect(sum.augend).to eq(five)
    expect(sum.addend).to eq(five)
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
