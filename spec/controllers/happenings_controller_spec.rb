require 'rails_helper'

RSpec.describe HappeningsController, type: :controller do

  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template :index
    end

    it 'should combine events and gatherings and sort them' do
      a = create(:event, date: Date.today + 1.year)
      b = create(:event, name: 'something else', date: Date.today)
      c = create(:gathering, group_id: 1, creator_id: 1, date: Date.today + 1.day)
      d = create(:event, name: 'hi', date: Date.today + 3.days)
      get :index
      expect(assigns(:happenings)).to match_array [b, c, d, a]
    end
  end
end
