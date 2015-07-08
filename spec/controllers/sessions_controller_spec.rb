require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET #new' do
    it 'should return http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'should sign the user in' do
        user = create(:user)
        attrs = attributes_for(:user)
        post :create, session: attrs
        expect(controller.current_user).to eq(user)
        expect(controller.signed_in?).to eq(true)
      end
    end
  end
end
