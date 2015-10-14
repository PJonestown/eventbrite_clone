require 'rails_helper'

RSpec.describe HappeningsController, type: :controller do

  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template :index
    end

    it 'should only assign upcoming happenings to @happenings' do
      past_event = create(:event, date: Time.zone.today - 1.year)
      get :index
      expect(assigns(:happenings)).not_to include past_event
    end
  end
end
