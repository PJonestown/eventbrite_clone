require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:creator)       { create(:user) }
  let(:event)         { create(:event, creator_id: creator.id) }
  let(:user)          { create(:other_user) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'renders show template' do
      get :show, id: event
      expect(response).to render_template :show
    end

    it 'assigns requested event as @event' do
      get :show, id: event
      expect(assigns(:event)).to eq event
    end
  end

  describe 'GET #new' do
    context 'guest' do
      it 'should redirect' do
        get :new
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'signed in user' do
      before do
        request.session[:user_id] = user.id
      end

      it 'should return http success' do
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'should assign a new user to @user' do
        get :new
        expect(assigns(:event)).to be_a_new(Event)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        request.session[:user_id] = user.id
      end

      it 'saves a new event to the database' do
        expect {
          post :create, event: attributes_for(:event)
        }.to change(Event, :count).by(1)
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid attrivutes' do
      it 'should not save the event' do
        expect {
          post :create, event: attributes_for(:invalid_event)
        }.to change(Event, :count).by(0)
      end
    end
  end
end
