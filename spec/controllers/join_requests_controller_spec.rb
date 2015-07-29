require 'rails_helper'

RSpec.describe JoinRequestsController, type: :controller do

  before :each do
    @owner = create(:user)
    @group = create(:private_group, owner_id: @owner.id)
    @user = create(:other_user)
    request.session[:user_id] = @user.id
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, group_id: @group.id
      expect(response).to render_template :new
    end

    it 'assigns @join_request as a new join_request' do
      get :new, group_id: @group.id
      expect(assigns(:join_request)).to be_a_new JoinRequest
    end

    it 'assigns the correct group as @group' do
      get :new, group_id: @group.id
      expect(assigns(:group)).to eq @group
    end

    context 'guest' do
      it 'should redirect' do
        request.session[:user_id] = nil
        get :new, group_id: @group.id
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'POST #create' do
    context 'signed in user' do
      context 'with valid attributes' do
        it 'should save the join_request to the database'do
          expect {
            post :create, :group_id => @group,
                          :join_request => attributes_for(:join_request,
                                                        user_id: @user.id)
          }.to change(JoinRequest, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'not save the request to database' do
          expect {
            post :create, :group_id => @group,
                          :join_request => attributes_for(:invalid_join_request,
                                                        user_id: @user.id)
          }.not_to change(JoinRequest, :count)
        end
      end
    end
  end

  describe "GET #index" do
    context 'group owner' do

      before :each do
        request.session[:user_id] = @owner.id
      end

      it 'renders the index template' do
        get :index, group_id: @group.id
        expect(response).to render_template :index
      end

      it 'assigns all group join_requests to @join_requests' do
        a = create(:join_request, group_id: @group.id, user_id: @user.id)
        create(:join_request, group_id: @group.id + 1, user_id: @user.id)
        b = create(:join_request, group_id: @group.id, user_id: @user.id)
        get :index, group_id: @group.id
        expect(assigns(:join_requests)).to match_array([a, b])
      end
    end

    context 'incorrect group owner' do
      it 'should redirect' do
        create(:group, owner_id: @user.id)
        get :index, group_id: @group.id
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'guest' do
      it 'should redirect' do
        request.session[:user_id] = nil
        get :index, group_id: @group.id
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
