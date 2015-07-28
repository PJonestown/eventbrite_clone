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

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns the categories as @categories' do
      a = create(:category)
      b = create(:category, name: 'hey')
      get :index
      expect(assigns(:categories)).to match_array [a, b]
    end
  end
end
