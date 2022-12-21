require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.create(name: 'Samiullah', email: 'samiullahk997@gmail.com', password: 'samiullah')
    @user.save
  end

  context 'This Testing Validations' do
    it 'is validate with all attributes' do
      expect(@user).to be_valid
    end
    it 'is not valid with out name attributes' do
      @user.name = nil
      expect(@user).to_not be_valid
    end
    it 'is not valid with out email attributes' do
      @user.email = nil
      expect(@user).to_not be_valid
    end
    it 'is not valid with out password attributes' do
      @user.password = nil
      expect(@user).to_not be_valid
    end
  end

  context 'This Testing Associations' do
    it 'has_many groups and categories' do
      assoc = User.reflect_on_association(:groups)
      expect(assoc.macro).to eq :has_many
    end
    it 'has_many expenses and transactions' do
      assoc = User.reflect_on_association(:expenses)
      expect(assoc.macro).to eq :has_many
    end
  end
end
