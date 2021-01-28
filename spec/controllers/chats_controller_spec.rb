require 'rails_helper'

RSpec.describe ChatsController, type: :controller do
  let(:chats) { create_list(:chat, 2) }
  let(:chat) { create(:chat) }
  let(:application) { create(:application) }
  let(:valid_attributes) { attributes_for(:chat) }

  describe 'GET #index' do
    before { chats;chat }
    context 'when retrieving application chats' do
      it 'returns success and correct number of chats' do 
        get :index, params: { application_token: chat.application.token }
        expect(response).to be_successful
        expect(json[:chats].count).to eq(1)
      end
    end
  end

  describe 'GET #show' do
    before { chat }
    context 'when showing an application chat with correct token and number' do
      it 'returns success and correct number of applications' do 
        get :show, params: { application_token: chat.application.token, number: chat.number}
        expect(response).to be_successful
        expect(json[:id]).to be_nil
      end
    end

    context 'when showing an applications with incorrect token' do
      it 'returns success and correct number of applications' do 
        get :show, params: { application_token: chat.application.token, number: "invalid token"}
        expect(response).to be_not_found
      end
    end
  end

  describe "POST #create" do
    context 'when givin valid params' do 
      it 'returns success' do 
        post :create, params: { application_token: application.token, chat: valid_attributes }
        expect(response).to be_successful
      end
    end

    # context 'when givin invalid params' do 
    #   it 'returns unprocessable entity with error key' do 
    #     post :create, params: { application: invalid_attributes }
    #     expect(response).to be_unprocessable
    #     expect(json[:name]).to be_present
    #   end
    # end
  end
  
  describe "PUT #update" do
    context 'when givin valid params' do 
      it 'returns success' do 
        post :create, params: { application_token: chat.application.token, number: chat.number, chat: valid_attributes }
        expect(response).to be_successful
      end
    end

    # context 'when givin invalid params' do 
    #   it 'returns unporcessable entity with error key' do 
    #     post :create, params: { application_token: chat.application.token, application: invalid_attributes }
    #     expect(response).to be_unprocessable
    #     expect(json[:name]).to be_present
    #   end
    # end
  end

  describe "DELETE #delete" do
    before { chat }
    context 'when givin valid token' do 
      it 'returns success and deletes record from table' do 
        expect do
          delete :destroy, params: { application_token: chat.application.token, number: chat.number }
        end.to change(Chat, :count).by(-1)
        expect(response).to be_successful
      end
    end

    context 'when givin invalid token' do
      it 'returns not found' do 
        expect do
          delete :destroy, params: { application_token: "invalid", number: "invalid token" }
        end.to change(Chat, :count).by(0)
        expect(response).to be_not_found
      end
    end
  end
end