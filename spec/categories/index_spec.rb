require 'rails_helper'

RSpec.feature 'This Categories Testing', type: :feature do
  before :each do
    @user = User.create(name: 'Samiullah', email: 'samiullahk997@gmail.com', password: 'samiullah')
    @category = Group.create(author: @user, name: 'cricket', icon: 'https://www.flaticon.com/svg/static/icons/svg/3144/3144456.svg')
    visit root_path
    click_link 'Log In'

    within('#new_user') do
      fill_in 'email', with: 'samiullahk997@gmail.com'
      fill_in 'password', with: 'samiullah'
    end
    click_button 'Log in'
  end

  it 'is redirects to transactions page' do
    within("#group_#{@category.id}") do
      click_on @category.name
    end
    expect(current_path).to match group_expenses_path(@category)
  end

  it 'is visited to categories page' do
    expect(current_path).to match groups_path
    expect(page).to have_content 'cricket'
  end
end
