require 'rails_helper'

RSpec.describe GatheringsController, type: :controller do
  before :each do
    @user = create(:user)
    @group = create(:group, owner_id: @user.id)
  end

  describe 'GET #show' do
    it 'should render the show template' do
      gathering = create(:gathering, creator_id: 1)
      get :show, :group_id => @group.id, id: gathering
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'guest' do
      it 'should redirect' do
        get :new, :group_id => @group.id
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'grouop owner' do
      before :each do
        request.session[:user_id] = @user.id
      end

      it 'should return http success' do
        get :new, :group_id => @group.id
        expect(response).to have_http_status(:success)
      end

      it 'should assign a new gathering to @gathering' do
        get :new, :group_id => @group
        expect(assigns(:gathering)).to be_a_new(Gathering)
      end
    end

    context 'signed in but not owner' do
      it 'should redirect' do
        other_user = create(:other_user)
        request.session[:user_id] = other_user.id

        get :new, :group_id => @group
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      it 'should save gathering to the database' do
        request.session[:user_id] = @user.id
        expect {
          post :create, :group_id => @group, :gathering => attributes_for(:gathering)
        }.to change(Gathering, :count).by(1)
      end
    end

    context 'invalid attributes' do
      it 'should not save gathering to the database' do
        expect {
          post :create, :group_id => @group, :gathering => attributes_for(:invalid_gathering)
        }.not_to change(Gathering, :count)
      end
    end
  end
end