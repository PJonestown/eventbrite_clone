require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #new' do
    it 'should return http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'should assign a new user to @user' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end
end
