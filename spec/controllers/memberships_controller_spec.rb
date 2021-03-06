require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do

  let(:owner)       { create(:user) }
  let(:group)       { create(:group, owner_id: owner.id) }
  let(:user)        { create(:other_user) }
  let(:mod)         { create(:user, username: 'the_mod') }

  before do
    request.env['HTTP_REFERER'] = 'root'
  end

  describe 'GET #index' do
    it 'should render the index template' do
      get :index, group_id: group.id
      expect(response).to render_template :index
    end

    it 'assigns @group to the correct group' do
      get :index, group_id: group.id
      expect(assigns(:group)).to eq group
    end

    it "should assign group's memberships to @memberships" do
      Membership.create(member_id: owner.id,
                        group_membership_id: group.id + 1)
      a = Membership.create(member_id: owner.id,
                            group_membership_id: group.id)
      b = Membership.create(member_id: owner.id,
                            group_membership_id: group.id)
      get :index, group_id: group.id
      expect(assigns(:memberships)).to match_array([a, b])
    end
  end

  describe 'POST #create' do
    context 'group owner' do

      before do
        request.session[:user_id] = owner.id
      end

      context 'already joined' do
        it 'should create new membership for user' do
          expect {
            post :create, :group_id => group,
                          :membership => attributes_for(:membership,
                                                        member_id: user.id,
                                                        group_membership_id: group.id)
          }.to change(Membership, :count).by(1)
        end

        xit 'should have success flash' do
          post :create, :group_id => group,
                        :membership => attributes_for(:membership,
                                                      member_id: user.id,
                                                      group_membership_id: group.id)
          expect(flash[:success]).to be_present
        end
      end
    end

    context 'user' do
      it 'should save membership to database' do
        request.session[:user_id] = user.id
        expect {
          post :create, :group_id => group,
                        :membership => attributes_for(:membership,
                                                      member_id: user.id,
                                                      group_membership_id: group.id)
        }.to change(Membership, :count).by(1)
      end

      context 'private group' do
        it 'should not save membership to database' do
          private_group = create(:private_group, owner_id: owner.id)
          request.session[:user_id] = user.id
          expect {
            post :create, :group_id => private_group.id,
                          :membership => attributes_for(:membership,
                                                        member_id: user.id,
                                                        group_membership_id: private_group.id)
          }.not_to change(Membership, :count)
        end
      end
    end

    context 'guest' do
      it 'should not save membership to database' do
        expect {
          post :create, :group_id => group,
                        :membership => attributes_for(:membership,
                                                      member_id: user.id,
                                                      group_membership_id: group.id)
        }.not_to change(Membership, :count)
      end
    end
  end

  context 'mod' do
    context 'private' do

      before do
        Membership.create(member_id: mod.id, group_membership_id: group.id)
        Moderation.create(moderator_id: mod.id, moderated_group_id: group.id)
        request.session[:user_id] = mod.id
      end

      it 'should save user to the database' do
        expect {
          post :create, :group_id => group,
                        :membership => attributes_for(:membership,
                                                      member_id: user.id,
                                                      group_membership_id: group.id)
        }.to change(Membership, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      request.session[:user_id] = user.id
    end

    context 'own membership' do
      it 'should delete the membership' do
        membership = create(:membership, member_id: user.id, group_membership_id: group.id)
        expect {
          delete :destroy, :group_id => group, id: membership
        }.to change(Membership, :count).by(-1)
      end
    end

    context "another user's membership" do
      it 'should not delete the membership' do
        membership = create(:membership, member_id: owner.id, group_membership_id: group.id)
        expect {
          delete :destroy, :group_id => group, id: membership
        }.not_to change(Membership, :count)
      end
    end
  end
end
