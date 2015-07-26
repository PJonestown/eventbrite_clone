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

  describe 'POST #create' do
    context 'group owner' do

      context 'with valid attributes' do
        it 'should save moderation to the database' do
          request.session[:user_id] = @owner.id
          expect {
            post :create, :user_id => @user,
              :moderation => { :moderator_id => @user,
                               :moderated_group_id => @group }
          }.to change(Moderation, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'should not ssave the moderation to the database' do
          request.session[:user_id] = @owner.id
          expect {
            post :create, :user_id => @user,
              :moderation => { :moderator_id => @user,
                               :moderated_group_id => nil }
          }.to_not change(Moderation, :count)
        end
      end
    end

    context 'non-group owner' do
      it 'should not save a moderation to the database' do
        request.session[:user_id] = @user.id
        expect {
          post :create, :user_id => @owner,
            :moderation => { :moderator_id => @owner,
                             :moderated_group_id => @group }
        }.not_to change(Moderation, :count)
      end
    end

    context 'guest' do
      it 'should not save moderation to database' do
        expect {
          post :create, :user_id => @user,
            :moderation => { :moderator_id => @user,
                             :moderated_group_id => @group }
        }.not_to change(Moderation, :count)
      end
    end
  end
end
