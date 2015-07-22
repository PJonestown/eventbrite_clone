require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'Get #show' do
    let(:group) { create(:group) }
    let(:user) { create(:user) }

    it 'assigns the requested group as @group' do
      get :show, id: group
      expect(assigns(:group)).to eq group
    end

    it 'renders the show template' do
      get :show, id: group
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'guest' do
      it 'redirects guests to sign up form' do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'signed in user' do
      before :each do
        user = create(:user)
        request.session[:user_id] = user.id
      end

      it 'should render the new template' do
        get :new
        expect(response).to render_template :new
      end

      it 'should assign new group to @group' do
        get :new
        expect(assigns(:group)).to be_a_new(Group)
      end
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns @groups as an array of groups' do
      first = create(:group)
      second = create(:other_group)
      get :index
      expect(assigns(:groups)).to match_array([first, second])
    end
  end

  describe 'POST #create' do
    before :each do
      user = create(:user)
      request.session[:user_id] = user.id
    end

    context 'with valid attributes' do
      it 'saves a new event to the database' do
        expect {
          post :create, group: attributes_for(:group)
        }.to change(Group, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'should not save the group' do
        expect {
          post :create, group: attributes_for(:invalid_group)
        }.to change(Group, :count).by(0)
      end
    end
  end
end
