require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) { User.create(name: 'King', email: 'king@gmail.com', password: 'password') }
  let(:car) { Car.create(name: 'Honda Civic', price: 20_000) }

  it 'Reservation is not valid without a date' do
    reservation = Reservation.new(city: 'Berlin')
    expect(reservation).not_to be_valid
  end

  it 'Reservation is not valid without a city name' do
    reservation = Reservation.new(date: '2002-12-12')
    expect(reservation).not_to be_valid
  end

  it 'Reservation of car is valid with valid attributes' do
    reservation = Reservation.new(user:, car:, date: Date.today, city: 'New York')
    expect(reservation).to be_valid
  end

  it 'Reservation belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq :belongs_to
  end

  it 'Reservation belongs to a car' do
    association = described_class.reflect_on_association(:car)
    expect(association.macro).to eq :belongs_to
  end
end
