require 'rails_helper'

RSpec.describe GroupsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
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

end
