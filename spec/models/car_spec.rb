require 'rails_helper'

RSpec.describe Car, type: :model do
  it 'is not valid without a name' do
    car = Car.new(price: '300')
  expect(car).not_to be_valid
  end

  it 'is not valid without a price' do
    car = Car.new(name: 'rover')
  expect(car).not_to be_valid
  end

  it "is valid with valid attributes" do
    car = Car.new(name: "Toyota Camry", price: 25000)
    expect(car).to be_valid
  end

  it "is not valid with a name longer than 100 characters" do
    car = Car.new(name: "A" * 101, price: 28000)
    expect(car).not_to be_valid
    expect(car.errors[:name]).to include("is too long (maximum is 100 characters)")
  end

  it "has many reservations" do
    association = described_class.reflect_on_association(:reservations)
    expect(association.macro).to eq :has_many
  end
end