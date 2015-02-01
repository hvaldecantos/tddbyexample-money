require 'spec_helper'

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

  it "can be added using mixed currencies" do
    five_bucks = Money.dollar(5)
    ten_francs = Money.franc(10)
    bank = Bank.new
    bank.add_rate("CHF", "USD", 2)
    result = bank.reduce(five_bucks.plus(ten_francs), "USD")
    expect(result).to eq(Money.dollar(10))
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

  it "gives 1 as exchange rate from same currency" do
    expect(1).to eq(Bank.new.rate("USD", "USD"))
  end

  it "reduces Money with different currency" do
    bank = Bank.new
    bank.add_rate("CHF", "USD", 2)
    result = bank.reduce(Money.franc(2), "USD")
    expect(result).to eq(Money.dollar(1))
  end
end

RSpec.describe "Sum" do
  it "can be added Money" do
    five_bucks = Money.dollar(5)
    ten_francs = Money.franc(10)
    bank = Bank.new
    bank.add_rate("CHF", "USD", 2)
    sum = Sum.new(five_bucks, ten_francs).plus(five_bucks)
    result = bank.reduce(sum, "USD")
    expect(result).to eq(Money.dollar(15))
  end

  it "can be multiplied" do
    five_bucks = Money.dollar(5)
    ten_francs = Money.franc(10)
    bank = Bank.new
    bank.add_rate("CHF", "USD", 2)
    sum = Sum.new(five_bucks, ten_francs).times(2)
    result = bank.reduce(sum, "USD")
    expect(result).to eq(Money.dollar(20))
  end
end
