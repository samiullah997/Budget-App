require 'rails_helper'

RSpec.describe GroupExpense, type: :model do
  before :each do
    @user = User.create(name: 'Samiullah', email: 'samiullahk997@gmail.com', password: 'samiullah')
    @category = Group.create(author: @user, name: 'Sports', icon: 'fas fa-ball')
    @transaction = Expense.create(author: @user, name: 'Cricket: ICC', amount: 49.99)
    @category_transaction = GroupExpense.new(group: @category, expense: @transaction)
  end

  context 'This Testing Validations' do
    it 'is valid with all attributes' do
      expect(@category_transaction).to be_valid
    end

    it 'is valid without a category group_id' do
      @category_transaction.group_id = nil
      expect(@category_transaction).to_not be_valid
    end

    it 'is valid without an category expense_id' do
      @category_transaction.expense_id = nil
      expect(@category_transaction).to_not be_valid
    end
  end

  context 'This Testing Associations' do
    it 'is belongs_to recipe' do
      assoc = GroupExpense.reflect_on_association(:group)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'is belongs_to food' do
      assoc = GroupExpense.reflect_on_association(:expense)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
