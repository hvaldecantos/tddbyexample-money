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
  def reduce bank, to
    rate = bank.rate currency, to
    Money.new(amount / rate, to)
  end
  def currency
    @currency
  end

  attr_reader :amount
end
