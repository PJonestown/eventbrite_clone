require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  
  before :each do
    @owner = create(:user)
    @group = create(:group, owner_id: @owner.id)
    @user = create(:other_user)
  end
  
  describe 'GET #index' do
    it 'should render the index template' do
      get :index, group_id: @group.id
      expect(response).to render_template :index
    end

    it 'assigns @group to the correct group' do
      get :index, group_id: @group.id
      expect(assigns(:group)).to eq @group
    end

    it "should assign group's memberships to @memberships" do
      Membership.create(member_id: @owner.id,
                        group_membership_id: @group.id + 1)
      a = Membership.create(member_id: @owner.id,
                            group_membership_id: @group.id)
      b = Membership.create(member_id: @owner.id,
                            group_membership_id: @group.id)
      get :index, group_id: @group.id
      expect(assigns(:memberships)).to match_array([a, b])
    end
  end

end
