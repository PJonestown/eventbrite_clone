require 'rails_helper'

RSpec.describe GatheringsController, type: :controller do
  let(:owner)              { create(:user) }
  let(:group)              { create(:group, owner_id: owner.id) }
  let(:member)             { create(:other_user) }
  let(:mod)                { create(:user, username: 'the_mod') }
  let(:user)               { create(:user, username: 'another_user') }
  let(:approval_params)    { attributes_for(:unapproved_gathering,
                                              approved: true,
                                              creator_id: user.id,
                                              group_id: group.id) }
  let(:valid_params)       { attributes_for(:unapproved_gathering,
                                              name: 'new_name',
                                              description: 'new_desc',
                                              creator_id: user.id,
                                              group_id: group.id) }
  let(:gathering)          { create(:unapproved_gathering,
                                      creator_id: user.id,
                                      group_id: group.id) }

  before :each do
    Membership.create(member_id: owner.id, group_membership_id: group.id)
    Membership.create(member_id: member.id,
                      group_membership_id: group.id)
    request.env['HTTP_REFERER'] = 'root'
  end

  describe 'GET #show' do
    it 'should render the show template' do
      gathering = create(:gathering, creator_id: 1)
      get :show, :group_id => group.id, id: gathering
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    context 'any group member permission' do
      context 'guest' do
        it 'should redirect' do
          get :new, :group_id => group.id
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'group owner' do
        before :each do
          request.session[:user_id] = owner.id
        end

        it 'should render new template' do
          get :new, :group_id => group.id
          expect(response).to render_template :new
        end

        it 'should assign a new gathering to @gathering' do
          get :new, :group_id => group
          expect(assigns(:gathering)).to be_a_new(Gathering)
        end
      end

      context 'signed in but not member' do
        it 'should redirect' do
          request.session[:user_id] = user.id

          get :new, :group_id => group
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'group member' do
        before :each do
          Membership.create(member_id: member.id,
                            group_membership_id: group.id)
          request.session[:user_id] = member.id
        end

        it 'should render new template' do
          get :new, :group_id => group.id
          expect(response).to render_template :new
        end

        it 'should assign a new gathering to @gathering' do
          get :new, :group_id => group
          expect(assigns(:gathering)).to be_a_new(Gathering)
        end
      end
    end

    context 'Restricted permission' do
      before :each do
        group.restricted = true
      end

      context 'guest' do
        it 'should redirect' do
          get :new, :group_id => group.id
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'group owner' do
        before :each do
          request.session[:user_id] = owner.id
        end

        it 'should render new template' do
          get :new, :group_id => group.id
          expect(response).to render_template :new
        end

        it 'should assign a new gathering to @gathering' do
          get :new, :group_id => group
          expect(assigns(:gathering)).to be_a_new(Gathering)
        end
      end

      context 'signed in but not member' do
        it 'should redirect' do
          request.session[:user_id] = user.id

          get :new, :group_id => group
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'group member' do
        before :each do
          Membership.create(member_id: member.id,
                            group_membership_id: group.id)
          request.session[:user_id] = member.id
        end

        it 'should render new template' do
          get :new, :group_id => group.id
          expect(response).to render_template :new
        end

        it 'should assign @gathering as a new gathering' do
          get :new, :group_id => group
          expect(assigns(:gathering)).to be_a_new(Gathering)
        end
      end

      context 'moderator' do
        before :each do
          Membership.create(member_id: mod.id, group_membership_id: group.id)
          Moderation.create(moderator_id: mod.id, moderated_group_id: group.id)
          request.session[:user_id] = mod.id
        end

        it 'should render new template' do
          get :new, :group_id => group.id
          expect(response).to render_template :new
        end

        it 'should assign a new gathering to @gathering' do
          get :new, :group_id => group
          expect(assigns(:gathering)).to be_a_new(Gathering)
        end
      end
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      it 'should save gathering to the database' do
        request.session[:user_id] = owner.id
        expect {
          post :create, :group_id => group, :gathering => attributes_for(:gathering)
        }.to change(Gathering, :count).by(1)
      end
    end

    context 'invalid attributes' do
      it 'should not save gathering to the database' do
        expect {
          post :create, :group_id => group, :gathering => attributes_for(:invalid_gathering)
        }.not_to change(Gathering, :count)
      end
    end
  end

  describe 'PATCH #update' do
    context 'private group' do
      before :each do
        group.restricted = true
      end

      context 'mod' do
        context 'valid attributes' do
          before :each do
            Moderation.create(moderator_id: mod.id,
                              moderated_group_id: group.id)
            request.session[:user_id] = mod.id
          end

          it 'should update the approved param' do
            patch :update, group_id: group.id, id: gathering.id,
              gathering: approval_params
            gathering.reload
            expect(gathering.approved).to eq true
          end

          it 'should not update any other params' do
            patch :update, group_id: group.id, id: gathering.id,
              gathering: valid_params
            gathering.reload
            expect(gathering.name).not_to eq 'new_name'
            expect(gathering.description).not_to eq 'new_desc'
          end
        end
      end

      context 'wrong group member' do
        context 'valid attributes' do
          before :each do
            Membership.create(member_id: member.id,
                              group_membership_id: group.id)
            request.session[:user_id] = member.id
          end

          it 'should not update attributes' do
            patch :update, group_id: group.id, id: gathering.id,
              gathering: valid_params
            gathering.reload
            expect(gathering.approved).not_to eq true
          end
        end
      end

      context 'group owner' do
        before :each do
          request.session[:user_id] = owner.id
        end

        it 'updates attributes' do
          patch :update, group_id: group.id, id: gathering.id,
            gathering: approval_params
          gathering.reload
          expect(gathering.approved).to eq true
        end
      end

      context 'gathering creator' do
        before :each do
          request.session[:user_id] = user.id
        end

        it 'should not update approved attribute' do
          patch :update, group_id: group.id, id: gathering.id,
            gathering: approval_params
          gathering.reload
          expect(gathering.approved).not_to eq true
        end

        it 'updates all other attributes' do
          patch :update, group_id: group.id, id: gathering.id,
             gathering: valid_params
          gathering.reload
          expect(gathering.approved).not_to eq true
        end
      end
    end
  end
end
