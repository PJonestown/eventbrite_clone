require 'rails_helper'

RSpec.describe JoinRequestsController, type: :controller do

  before :each do
    @owner = create(:user)
    @group = create(:private_group, owner_id: @owner.id)
    @user = create(:other_user)
  end
  describe "GET #new" do
    it "returns http success" do
      get :new, group_id: @group.id
      expect(response).to render_template :new
    end

    it 'assigns @join_request as a new join_request' do
      get :new, group_id: @group.id
      expect(assigns(:join_request)).to be_a_new (JoinRequest)
    end

    it 'assigns the correct group as @group' do
      get :new, group_id: @group.id
      expect(assigns(:group)).to eq @group
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, group_id: @group.id
      expect(response).to render_template :index
    end
  end

end
