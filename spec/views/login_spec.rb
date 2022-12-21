require 'rails_helper'

RSpec.feature 'Testing Log In', type: :feature do
  before :each do
    @user = User.create(name: 'Samiullah', email: 'Samiullahk997@gmail.com', password: 'samiullah')
    visit root_path
    click_link 'Log In'
  end

  it 'is for signs me in' do
    within('#new_user') do
      fill_in 'email', with: 'samiullahk997@gmail.com'
      fill_in 'password', with: 'samiullah'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  it 'is not sign me in when the email and password are not correct' do
    within('#new_user') do
      fill_in 'email', with: 'sami@gmail.com'
      fill_in 'password', with: 'sami'
    end
    click_button 'Log in'
    expect(current_path).to match new_user_session_path
    expect(page).to have_content 'Invalid Email or password'
  end
end