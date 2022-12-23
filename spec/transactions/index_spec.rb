require 'rails_helper'

RSpec.feature 'Transactions Testing', type: :feature do
  before :each do
    @user = User.create(name: 'sami', email: 'sami@gmail.com', password: 'samiullah')
    @category = Group.create(author: @user, name: 'Sports', icon: 'https://t3.ftcdn.net/jpg/03/13/24/94/360_F_313249442_rVaztYCo9u5FOKtxWWGtKgw38AVvt7Qb.jpg')
    @transaction = Expense.create(author: @user, name: 'Tennis Ball', amount: 50, groups: [@category])

    visit root_path
    click_link 'Log In'

    within('#new_user') do
      fill_in 'email', with: 'sami@gmail.com'
      fill_in 'password', with: 'samiullah'
    end
    click_button 'Log in'
    visit group_expenses_path(@category)
  end

  it 'is for visits categories page' do
    expect(page).to have_content 'Sports\' Transactions'
  end

  it 'is for total transactions price' do
    expect(page).to have_content "sami : $#{@transaction.amount}"
  end
end
