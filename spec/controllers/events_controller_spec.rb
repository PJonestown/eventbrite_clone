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
      end

      it 'has success flash' do
        post :create, event: attributes_for(:event)
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

  describe 'GET #edit' do
    context 'event creator' do

      before do
        request.session[:user_id] = creator.id
      end

      it 'renders the edit template' do
        get :edit, id: event
        expect(response).to render_template :edit
      end

      it 'should assign @event to the event' do
        get :edit, id: event
        expect(assigns(:event)).to eq event
      end
    end

    context 'wrong user' do

      before do
        request.session[:user_id] = user.id
        request.env['HTTP_REFERER'] = 'root'
      end

      it 'should redirect' do
        get :edit, id: event
        expect(response).to have_http_status :redirect
      end
    end

    context 'guest' do

      it 'should redirect' do
        get :edit, id: event.id
        expect(response).to have_http_status :redirect
      end
    end
  end

  describe 'PATCH #update' do
    context 'correct user' do

      before do
        request.session[:user_id] = creator.id
      end

      context 'with valid attributes' do

        it 'should update the event' do
          patch :update, id: event, event: attributes_for(:another_event)
          event.reload
          expect(event.title).to eq 'Backroom 100nl poker meetup'
        end

        it 'should have a success flash' do
          patch :update, id: event, event: attributes_for(:another_event)
          expect(flash[:success]).to be_present
        end

        it 'should redirect' do
          patch :update, id: event, event: attributes_for(:another_event)
          expect(response).to have_http_status :redirect
        end
      end

      context 'with invalid attributes' do

        it 'should not update the event' do
          patch :update, id: event, event: attributes_for(:invalid_event)
          event.reload
          expect(event.title).not_to eq ''
        end

        it 'should render edit template' do
          patch :update, id: event, event: attributes_for(:invalid_event)
          expect(response).to render_template :edit
        end
      end
    end

    context 'incorrect user' do

      before do
        request.session[:user_id] = user.id
        request.env['HTTP_REFERER'] = 'root'
      end

      it 'should not update event' do
        patch :update, id: event, event: attributes_for(:another_event)
        event.reload
        expect(event.title).not_to eq 'Backroom 100nl poker meetup'
      end

      it 'should redirect' do
        patch :update, id: event, event: attributes_for(:another_event)
        expect(response).to have_http_status :redirect
      end
    end

    context 'guest' do

      before do
        request.env['HTTP_REFERER'] = 'root'
      end

      it 'should not update event' do
        patch :update, id: event, event: attributes_for(:another_event)
        event.reload
        expect(event.title).not_to eq 'Backroom 100nl poker meetup'
      end

      it 'should redirect' do
        patch :update, id: event, event: attributes_for(:another_event)
        expect(response).to have_http_status :redirect
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'event creator' do

      before do
        request.session[:user_id] = creator.id
        @event = create(:event, creator_id: creator.id)
      end

      it 'deletes the event' do
        expect {
          delete :destroy, id: @event
        }.to change(Event, :count).by(-1)
      end

      it 'redirects' do
        delete :destroy, id: @event
        expect(response).to have_http_status :redirect
      end

      it 'has success flash' do
        delete :destroy, id: @event
        expect(flash[:success]).to be_present
      end
    end
  end

  context 'incorrect user' do

    before do
      @event = create(:event, creator_id: creator.id)
      request.session[:user_id] = user.id
      request.env['HTTP_REFERER'] = 'root'
    end

    it 'should not delete event' do
      expect {
        delete :destroy, id: @event
      }.to change(Group, :count).by 0
    end
  end

  context 'guest' do

    before do
      @event = create(:event, creator_id: creator.id)
      request.env['HTTP_REFERER'] = 'root'
    end

    it 'should not delete event' do
      expect {
        delete :destroy, id: @event
      }.to change(Group, :count).by 0
    end
  end
end
