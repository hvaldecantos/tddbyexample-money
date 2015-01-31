require 'rspec/core'

class Sum
  def initialize augend, addend
    @augend = augend
    @addend = addend
  end
  def reduce to
    amount = augend.amount + addend.amount
    Money.new(amount, to)
  end

  attr_reader :augend
  attr_reader :addend
end

class Bank
  def reduce source, to
    source.reduce to
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
    Sum.new self, addend
  end
  def currency
    @currency
  end

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

RSpec.describe "Bank" do
  it "reduces a Sum" do
    sum = Sum.new(Money.dollar(3), Money.dollar(4))
    bank = Bank.new
    result = bank.reduce(sum, "USD")
    expect(result).to eq(Money.dollar(7))
  end

  it "reduces Money" do
    bank = Bank.new
    result = bank.reduce(Money.dollar(1), "USD")
    expect(result).to eq(Money.dollar(1))
  end
end
