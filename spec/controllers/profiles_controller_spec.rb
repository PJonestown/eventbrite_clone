require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  before do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      'New York', [
        {
          'location'     => 'New York',
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731
        }
      ]
    )
    end

  let(:user) { create(:user) }
  let(:profile) { create(:profile) }

  describe 'GET #new' do
    it 'renders new template' do
      get :new, :user_id => user
      expect(response).to render_template :new
    end

    it 'should assign a new profile to @profile' do
      get :new, user_id: user
      expect(assigns(:profile)).to be_a_new(Profile)
    end
  end

  describe "POST #create" do
    context 'user'

    before do
      request.session[:user_id] = user.id
    end

    context 'valid attributes' do
      it 'should save profile to the database' do
        expect {
          post :create, :user_id => user, :profile => attributes_for(:profile)
        }.to change(Profile, :count).by(1)
      end

      it 'should have a success flash' do
        post :create, :user_id => user, :profile => attributes_for(:profile)
        expect(flash[:success]).to be_present
      end
    end

    context 'invalid attributes' do
      it 'should not save gathering to the database' do
        expect {
          post :create, :user_id => user,
                        :profile => attributes_for(:invalid_profile)
        }.not_to change(Profile, :count)
      end
    end
  end

  describe "GET #show" do
    it 'should render the show template' do
      get :show, :user_id => user, :id => profile
      expect(response).to render_template :show
    end

    it 'should assign @profile to the user profile' do
      get :show, :user_id => user, :id => profile
      expect(assigns(:profile)).to eq profile
    end
  end

  describe "GET #edit" do
    it 'should render the edit template' do
      get :edit, :user_id => user, :id => profile
      expect(response).to render_template :edit
    end

    it 'should assign @profile to the user profile' do
      get :edit, :user_id => user, :id => profile
      expect(assigns(:profile)).to eq profile
    end

  end

  describe "PATCH #update" do
  end

end
