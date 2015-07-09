require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET #new' do
    it 'should return http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with saved user' do
      it 'should sign the user in' do
        user = create(:user)
        attrs = attributes_for(:user)
        post :create, session: attrs
        expect(controller.current_user).to eq(user)
        expect(controller.signed_in?).to eq(true)
      end
    end

    context 'with unsaved user' do
      it 'should not create a session and redirect' do
        attrs = attributes_for(:user)
        post :create, session: attrs
        expect(controller.signed_in?).to eq(false)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with signed in user' do
      it 'should end the user session' do
        create(:user)
        attrs = attributes_for(:user)
        post :create, session: attrs
        expect(controller.signed_in?).to eq(true)
        delete :destroy, session: attrs
        expect(controller.signed_in?).to eq(false)
      end
    end
  end
end
