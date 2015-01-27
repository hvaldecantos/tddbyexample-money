require 'rspec/core'

RSpec.describe "Money" do
  it "can be multiplied" do
    five = Dollar.new(5)
    five.times(2)
    expect(five.amount).to eq(10)
  end
end
