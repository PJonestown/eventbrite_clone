require 'rails_helper'

RSpec.describe ModResourcesController, type: :controller do

  before :each do
    @mod = create(:user)
    request.env['HTTP_REFERER'] = 'root'
  end

  describe 'GET #index' do
    context 'correct user' do
      before :each do
        request.session[:user_id] = @mod.id
      end

      it "renders index template" do
        get :index, user_id: @mod.id
        expect(response).to render_template :index
      end

      it 'assigns moderated groups to @moderated_groups' do
        owner = create(:other_user)
        first = create(:group, owner_id: owner.id)
        second = create(:group, name: 'another', owner_id: owner.id)
        Moderation.create(moderator_id: @mod.id, moderated_group_id: first.id)
        Moderation.create(moderator_id: @mod.id, moderated_group_id: second.id)

        get :index, user_id: @mod.id
        expect(assigns(:moderated_groups)).to eq [first, second]
      end

      it 'assigns owned groups to @owned_groups' do
        first = create(:group, owner_id: @mod.id)
        second = create(:group, name: 'another', owner_id: @mod.id)

        get :index, user_id: @mod.id
        expect(assigns(:owned_groups)).to eq [first, second]
      end
    end

    context 'wrong user' do
      before :each do
        @wrong_user = create(:other_user)
        request.session[:user_id] = @wrong_user.id
      end

      it 'should redirect' do
        get :index, user_id: @mod.id
        expect(response).to have_http_status :redirect
      end
    end

    context 'guest' do
      it 'should redirect' do
        get :index, user_id: @mod.id
        expect(response).to have_http_status :redirect
      end
    end
  end
end
