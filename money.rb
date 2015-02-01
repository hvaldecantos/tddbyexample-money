class Sum
  def initialize augend, addend
    @augend = augend
    @addend = addend
  end
  def reduce bank, to
    amount = augend.reduce(bank, to).amount + addend.reduce(bank, to).amount
    Money.new(amount, to)
  end
  def plus addend
    Sum.new self, addend
  end
  def times multiplier
    Sum.new @augend.times(multiplier), @addend.times(multiplier)
  end

  attr_reader :augend
  attr_reader :addend
end

class Bank
  def initialize
    @rates = {}
  end
  def reduce source, to
    source.reduce self, to
  end
  def rate from, to
    return 1 if from == to
    @rates[[from, to]]
  end
  def add_rate from, to, rate
    @rates[[from, to]] = rate
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
  def reduce bank, to
    rate = bank.rate currency, to
    Money.new(amount / rate, to)
  end
  def currency
    @currency
  end

  attr_reader :amount
end
