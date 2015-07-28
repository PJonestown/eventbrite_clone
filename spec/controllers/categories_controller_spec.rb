require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #show' do
    it 'renders show template' do
      category = create(:category)
      get :show, id: category
      expect(response).to render_template :show
    end

    it 'assigns requested category as @category' do
      category = create(:category)
      get :show, id: category
      expect(assigns(:category)).to eq category
    end

    it "assigns category's groups ad @groups" do
      category = create(:category)
      group = create(:group, category_id: category.id)
      get :show, id: category
      expect(assigns(:groups)).to match_array [group]
    end
  end
end
