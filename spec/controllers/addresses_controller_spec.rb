require 'rails_helper'

RSpec.describe AddressesController, type: :controller do

  let(:address) {
    create(:address)
  }

  let(:user) {
    create(:user)
  }

  let(:valid_attributes) {
    attributes_for(:other_address)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_address)
  }

  let(:group) {
    create(:group)
  }


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

    Geocoder::Lookup::Test.add_stub(

      'Chicago', [
        {
          'location'    => 'Chicago',
          'latitude'    => 41.8781136,
          'longitude'   => -87.6297982
        }
      ]
    )
  end


  describe 'GET #show' do
    it 'should render the show template' do
      get :show, :group_id => group, id: address
      expect(response).to render_template :show
    end

    it 'should assign @address to the correct address' do
      get :show, group_id: group, id: address
      expect(assigns(:address)).to eq address
    end
  end

  describe 'GET #new' do
    context 'user' do

      before do
        request.session[:user_id] = user.id
      end

      it 'should render the new template' do
        get :new, :group_id => group
        expect(response).to render_template :new
      end

      it 'should assign @address to a new address' do
        get :new, group_id: group
        expect(assigns(:address)).to be_a_new(Address)
      end
    end

    context 'guest' do
      it 'should redirect' do
        get :new, group_id: group
        expect(response).to have_http_status :redirect
      end
    end
  end

  describe 'GET #edit' do
    context 'user' do

      before do
        request.session[:user_id] = user.id
      end

      it 'should render the edit template' do
        get :edit, group_id: group, id: address
        expect(response).to render_template :edit
      end

      it 'should assign @address to the correct address' do
        get :edit, group_id: group, id: address
        expect(assigns(:address)).to eq address
      end
    end

    context 'guest' do
      it 'should redirect' do
        get :edit, group_id: group, id: address
        expect(response).to have_http_status :redirect
      end
    end
  end
end

