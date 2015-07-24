require 'rails_helper'

RSpec.describe GatheringsController, type: :controller do
  before :each do
    @group = create(:group)
  end

  describe 'GET #new' do
    context 'guest' do
      it 'should redirect' do
        get :new, :group_id => @group
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'signed in user' do
      before :each do
        @user = create(:user)
        request.session[:user_id] = @user.id
      end

      it 'should return http success' do
        get :new, :group_id => @group
        expect(response).to have_http_status(:success)
      end

      # TODO: test for signed in user that isn't group owner

      # TODO: how test instance variables for nested resources?

      xit 'should assign a new gathering to @gathering' do
        get :new, :group_id => @group
        expect(assigns(:gathering)).to be_a_new(Gathering)
      end
    end
  end
end
