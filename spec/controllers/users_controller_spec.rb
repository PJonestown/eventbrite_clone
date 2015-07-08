require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns new User to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      user = create(:user)
      get :show, id: user
      expect(response).to render_template :show
    end

    it 'assigns requested user as @user' do
      user = create(:user)
      get :show, id: user
      expect(assigns(:user)).to eq user
    end
  end

end
