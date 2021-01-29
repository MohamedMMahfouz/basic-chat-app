require 'rails_helper'

RSpec.describe ApplicationsController, type: :controller do
  let(:applications) { create_list(:application, 2) }
  let(:application) { create(:application) }
  let(:valid_attributes) { attributes_for(:application) }
  let(:invalid_attributes) { attributes_for(:application, :invalid) }

  describe 'GET #index' do
    before { applications }
    context 'when retrieving all applications' do
      it 'returns success and correct number of applications' do 
        get :index
        expect(response).to be_successful
        expect(json[:applications].count).to eq(2)
      end
    end
  end

  describe 'GET #show' do
    before { application }
    context 'when showing an applications with correct token' do
      it 'returns success' do 
        get :show, params: {token: application.token}
        expect(response).to be_successful
        expect(json[:id]).to be_nil
        expect(json[:name]).to eq(application.name)
      end
    end

    context 'when showing an applications with incorrect token' do
      it 'returns not found' do 
        get :show, params: {token: "invalid token"}
        expect(response).to be_not_found
      end
    end
  end

  describe "POST #create" do
    context 'when given valid params' do 
      it 'returns success' do 
        post :create, params: { application: valid_attributes }
        expect(response).to be_successful
      end
    end

    context 'when given invalid params' do 
      it 'returns unprocessable entity with error key' do 
        post :create, params: { application: invalid_attributes }
        expect(response).to be_unprocessable
        expect(json[:name]).to be_present
      end
    end
  end
  
  describe "PUT #update" do
    context 'when given valid params' do 
      it 'returns success' do 
        post :create, params: { token: application.token, application: valid_attributes }
        expect(response).to be_successful
      end
    end

    context 'when given invalid params' do 
      it 'returns unporcessable entity with error key' do 
        post :create, params: { token: application.token, application: invalid_attributes }
        expect(response).to be_unprocessable
        expect(json[:name]).to be_present
      end
    end
  end

  describe "DELETE #delete" do
    before { application }
    context 'when given valid token' do 
      it 'returns success and deletes record from table' do 
        expect do
          delete :destroy, params: { token: application.token }
        end.to change(Application, :count).by(-1)
        expect(response).to be_successful
      end
    end

    context 'when given invalid token' do
      it 'returns not found' do 
        expect do
          delete :destroy, params: { token: "invalid token" }
        end.to change(Application, :count).by(0)
        expect(response).to be_not_found
      end
    end
  end
end