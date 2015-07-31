require 'rails_helper'

RSpec.describe GatheringsController, type: :controller do
  before :each do
    @owner = create(:user)
    @group = create(:group, owner_id: @owner.id)
    Membership.create(member_id: @owner.id, group_membership_id: @group.id)
    request.env['HTTP_REFERER'] = 'root'
  end

  describe 'GET #show' do
    it 'should render the show template' do
      gathering = create(:gathering, creator_id: 1)
      get :show, :group_id => @group.id, id: gathering
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'any group member permission' do
      context 'guest' do
        it 'should redirect' do
          get :new, :group_id => @group.id
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'group owner' do
        before :each do
          request.session[:user_id] = @owner.id
        end

        it 'should render new template' do
          get :new, :group_id => @group.id
          expect(response).to render_template :new
        end

        it 'should assign a new gathering to @gathering' do
          get :new, :group_id => @group
          expect(assigns(:gathering)).to be_a_new(Gathering)
        end
      end

      context 'signed in but not member' do
        it 'should redirect' do
          other_user = create(:other_user)
          request.session[:user_id] = other_user.id

          get :new, :group_id => @group
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'group member' do
        before :each do
          @member = create(:other_user)
          Membership.create(member_id: @member.id,
                            group_membership_id: @group.id)
          request.session[:user_id] = @member.id
        end

        it 'should render new template' do
          get :new, :group_id => @group.id
          expect(response).to render_template :new
        end

        it 'should assign a new gathering to @gathering' do
          get :new, :group_id => @group
          expect(assigns(:gathering)).to be_a_new(Gathering)
        end
      end
    end
  end


  describe 'POST #create' do
    context 'valid attributes' do
      it 'should save gathering to the database' do
        request.session[:user_id] = @owner.id
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
