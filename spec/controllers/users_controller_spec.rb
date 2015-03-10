require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'returns a 200 status' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates new contact" do
        expect{
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create,
          user: {username: 'dave', email: 'badbadbad'}
        }.not_to change(User, :count)
      end
      it "re-renders the :index template" do
        post :create,
        user: {username: 'dave', email: 'badbadbad'}
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    it 'renders the :dashboard template' do
     get :show, id: 1
      expect(response).to render_template :dashboard
    end

    it 'returns a 200 status' do
      get :show, id: 1
      expect(response.status).to eq(200)
    end
  end




end
