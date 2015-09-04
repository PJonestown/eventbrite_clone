require 'rails_helper'

RSpec.describe HappeningsController, type: :controller do

  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template :index
    end

    it 'should combine events and gatherings and sort them' do
      a = create(:event)
      b = create(:event, name: 'something else')
      c = create(:gathering, group_id: 1, creator_id: 1)
      d = create(:event, name: 'hi')
      get :index
      expect(assigns(:happenings)).to match_array [a, b, c, d]
    end
  end
end
