require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:owner) { create(:user) }
  let(:user) { create(:other_user) }
  let(:group) { create(:group, owner_id: owner.id) }
  let(:valid_params) { attributes_for(:group, name: 'Edited Name') }
  let(:invalid_params) { attributes_for(:group, name: '') }

  describe 'Get #show' do
    it 'assigns the requested group as @group' do
      get :show, id: group
      expect(assigns(:group)).to eq group
    end

    it 'renders the show template' do
      get :show, id: group
      expect(response).to render_template :show
    end

    it 'assigns only approved gatherings to @gatherings' do
      a = create(:gathering, group_id: group.id, creator_id: user.id)
      b = create(:gathering, group_id: group.id, name: 'anything else',
                 creator_id: user.id)
      create(:unapproved_gathering, group_id: group.id, creator_id: user.id)
      get :show, id: group
      expect(assigns(:gatherings)).to match_array([a, b])
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
      before do
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
    before do
      request.session[:user_id] = user.id
    end

    context 'with valid attributes' do
      it 'saves a new group to the database' do
        expect {
          post :create, group: attributes_for(:group)
        }.to change(Group, :count).by(1)
        expect(flash[:success]).to be_present
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

  context 'GET #edit' do
    context 'group owner' do
      before do
        request.session[:user_id] = owner.id
      end

      it 'should render the edit template' do
        get :edit, id: group
        expect(response).to render_template :edit
      end

      it 'assigns the group as @group' do
        get :edit, id: group
        expect(assigns(:group)).to eq group
      end
    end

    context 'incorrect member' do
      before do
        Membership.create(member_id: user.id, group_membership_id: group.id)
        request.session[:user_id] = user.id
        request.env['HTTP_REFERER'] = 'root'
      end

      it 'should redirect' do
        get :edit, id: group
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'mod' do
      before do
        Moderation.create(moderator_id: user.id, moderated_group_id: group.id)
        request.session[:user_id] = user.id
      end

      it 'should render the edit template' do
        get :edit, id: group
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    context 'owner' do

      before do
        request.session[:user_id] = owner.id
      end

      context 'valid params' do

        it 'should update the group' do
          patch :update, id: group,
            group: valid_params
          group.reload
          expect(group.name).to eq 'Edited Name'
        end

        it 'should redirect' do
          patch :update, id: group,
            group: valid_params
          expect(response).to have_http_status :redirect
        end

        it 'should have success flash' do
          patch :update, id: group,
            group: valid_params
          expect(flash[:success]).to be_present
        end
      end

      context 'invalid params' do

        it 'should not update params' do
          patch :update, id: group,
            group: invalid_params
          group.reload
          expect(group.name).not_to eq ''
        end

        it 'should render the edit template' do
          patch :update, id: group,
            group: invalid_params
          expect(response).to render_template :edit
        end
      end
    end

    context 'mod' do

      before do
        Moderation.create(moderator_id: user.id, moderated_group_id: group.id)
        request.session[:user_id] = user.id
      end

      context 'valid params' do
        it 'should update the group' do
          patch :update, id: group,
            group: valid_params
          group.reload
          expect(group.name).to eq 'Edited Name'
        end
      end
    end

    context 'unprivileged member' do
      before do
        request.env['HTTP_REFERER'] = 'root'
        Membership.create(member_id: user.id, group_membership_id: group.id)
        request.session[:user_id] = user.id
      end

      it 'should not update the group' do
        patch :update, id: group,
          group: valid_params
        group.reload
        expect(group.name).not_to eq 'Edited Name'
      end
    end

    context 'guest' do
      before do
        request.env['HTTP_REFERER'] = 'root'
      end

      it 'should not update the group' do
        patch :update, id: group,
          group: valid_params
        group.reload
        expect(group.name).not_to eq 'Edited Name'
      end
    end
  end
end
