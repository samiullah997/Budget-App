require 'rails_helper'

RSpec.describe 'Expenses Testing', type: :request do
  before :each do
    @user = User.create(name: 'Sami', email: 'sami@gmail.com', password: 'samiullah')
    @category = Group.create(author: @user, name: 'Movies')
    Expense.create([
                     { author: @user, name: 'Bat', amount: 100, groups: [@category] },
                     { author: @user, name: 'Ball', amount: 20, groups: [@category] }
                   ])

    sign_in @user
    get group_expenses_path(@category)
  end

  it 'for assigns all expenses to @expenses' do
    expect(assigns(:expenses)).to eq(@user.expenses.order(created_at: :desc))
  end

  it 'for renders index template' do
    expect(response).to render_template('index')
  end

  it 'for a success' do
    expect(response).to have_http_status(:ok)
  end
end