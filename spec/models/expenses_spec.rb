require 'rails_helper'

RSpec.describe Expense, type: :model do
  before :each do
    @user = User.create(name: 'Samiullah', email: 'samiullahk997@gmail.com', password: 'samiullah')
    @transaction = Expense.new(author: @user, name: 'Bat', amount: 100)
  end

  context 'This Testing Validations' do
    it 'is valid with all valid attributes' do
      expect(@transaction).to be_valid
    end

    it 'is not valid without a transaction name' do
      @transaction.name = nil
      expect(@transaction).to_not be_valid
    end

    it 'is not valid without an transaction icon' do
      @transaction.amount = nil
      expect(@transaction).to_not be_valid
    end

    it 'has amount, which is numeric data type' do
      expect(@transaction.amount).to be_kind_of Numeric
    end

    it 'is not valid without transaction user id' do
      @transaction.author_id = nil
      expect(@transaction).to_not be_valid
    end
  end

  context 'This Testing Associations' do
    it 'is belongs_to User' do
      assoc = Expense.reflect_on_association(:author)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'is has_many group_expenses' do
      assoc = Expense.reflect_on_association(:group_expenses)
      expect(assoc.macro).to eq :has_many
    end
  end
end
