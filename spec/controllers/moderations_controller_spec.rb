require 'rails_helper'

RSpec.describe ModerationsController, type: :controller do
  before :each do
    @owner = create(:user)
    @group = create(:group, owner_id: @owner.id)
    @user = create(:other_user)
  end

  describe 'GET # new' do
    context 'guest' do
      it 'should redirect' do
        get :new, user_id: @user
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'user with no owned groups' do
      it 'should redirect' do
        request.session[:user_id] = @user.id
        get :new, user_id: @owner
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'user with owned groups' do
      it 'should render template' do
        request.session[:user_id] = @owner.id
        get :new, user_id: @user
        expect(response).to render_template :new
      end

      it 'assigns @moderator as a new moderator' do
        request.session[:user_id] = @owner.id
        get :new, user_id: @user
        expect(assigns(:moderation)).to be_a_new(Moderation)
      end
    end
  end
end
