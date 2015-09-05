require 'rails_helper'

RSpec.describe HappeningsController, type: :controller do

  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template :index
    end

    it 'should combine events and gatherings and sort them' do
      a = create(:event, date: Time.zone.today + 1.year)
      b = create(:event, name: 'something else', date: Time.zone.today)
      c = create(:gathering, date: Time.zone.today + 1.day)
      d = create(:event, name: 'hi', date: Time.zone.today + 3.days)
      get :index
      expect(assigns(:happenings)).to match_array [b, c, d, a]
    end

    it 'should only assign upcoming happenings to @happenings' do
      past_event = create(:event, date: Time.zone.today - 1.year)
      get :index
      expect(assigns(:happenings)).not_to include past_event
    end
  end
end
