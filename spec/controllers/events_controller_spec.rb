require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #new' do
    context 'guest' do
      it 'should redirect' do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'signed in user' do
      before :each do
        @user = create(:user)
        request.session[:user_id] = @user.id
      end

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
end
