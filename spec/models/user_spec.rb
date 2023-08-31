require 'rails_helper'

RSpec.describe User, type: :model do
  it 'User is not valid without a name' do
    user = User.new(email: 'test@gamil.com', password: 'password')
    expect(user).not_to be_valid
  end

  it 'User is not valid without a password' do
    user = User.new(name: 'test', password: 'password')
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user = User.new(name: 'test', email: 'test@gmail.com')
    expect(user).not_to be_valid
  end

  it 'is valid with valid attributes' do
    user = User.new(name: 'King', email: 'king@gmail.com', password: 'password')
    expect(user).to be_valid
  end

  it 'has many reservations' do
    association = described_class.reflect_on_association(:reservations)
    expect(association.macro).to eq :has_many
  end
end
