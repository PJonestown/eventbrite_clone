require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  let(:user) { create(:user) }

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
  end

  describe "GET #show" do
  end

  describe "GET #edit" do
  end

  describe "PATCH #update" do
  end

end
