require 'rails_helper'

RSpec.describe 'Groups Testing', type: :request do
  before :each do
    @user = User.create(name: 'Samiullah', email: 'samiullahk997@gmail.com', password: 'samiullah')

    Group.create([
                   { author: @user, name: 'Sports', icon: 'https://e7.pngegg.com/pngimages/810/232/png-clipart-sport-logo-design-grass-sports-equipment.png' },
                   { author: @user, name: 'Movies', icon: 'https://png.pngtree.com/png-vector/20190816/ourmid/pngtree-film-logo-design-template-vector-isolated-illustration-png-image_1693431.jpg' }
                 ])

    sign_in @user
    get groups_path
  end

  it 'for assigns all categories to @groups' do
    expect(assigns(:groups)).to eq(@user.groups)
  end

  it 'for a renders index template' do
    expect(response).to render_template('index')
  end

  it 'for a success' do
    expect(response).to have_http_status(:ok)
  end
end