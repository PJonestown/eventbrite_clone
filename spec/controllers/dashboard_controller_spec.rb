require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #show' do
    it 'should combine events and gatherings and sort them' do
      a = create(:event)
      b = create(:event, name: 'something else')
      c = create(:gathering, group_id: 1, creator_id: 1)
      d = create(:event, name: 'hi')
      get :show, user_id: 1, id: 1
      expect(assigns(:combined)).to match_array [a, b, c, d]
    end
  end
end
