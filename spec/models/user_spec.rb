require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'Samiullah')
    @user.save
  end

  context 'Testing Validations' do
    it 'is validate with attributes' do
      expect(@user).to be_valid
    end
    it 'is not valid with out name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end
  end

  context 'Testing Associations' do
    it 'has_many groups/categories' do
      assoc = User.reflect_on_association(:groups)
      expect(assoc.macro).to eq :has_many
    end
    it 'has_many expenses/transactions' do
      assoc = User.reflect_on_association(:expenses)
      expect(assoc.macro).to eq :has_many
    end
  end
end
