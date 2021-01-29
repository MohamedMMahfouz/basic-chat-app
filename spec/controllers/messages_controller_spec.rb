require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:chat) { create(:chat) }
  let(:messages) { create_list(:message, 2) }
  let(:message) { create(:message) }
  let(:application) { create(:application) }
  let(:valid_attributes) { attributes_for(:message) }
  let(:invalid_attributes) { attributes_for(:message, :invalid) }

  describe 'GET #index' do
    before { messages; message }
    context 'when retrieving chat messages' do
      it 'returns success and correct number of messages' do 
        get :index, params: { application_token: message.chat.application.token,
        chat_number: message.chat.number }
        expect(response).to be_successful
        expect(json[:messages].count).to eq(1)
      end
    end
  end

  describe 'GET #show' do
    before { message }
    context 'when showing an application chat with correct token and number' do
      it 'returns success' do 
        get :show, params: { application_token: message.chat.application.token,
           chat_number: message.chat.number, number: message.number}
        expect(response).to be_successful
        expect(json[:id]).to be_nil
      end
    end

    context 'when showing an applications with incorrect token' do
      it 'returns not found' do 
        get :show, params: { application_token: message.chat.application.token,
          chat_number: message.chat.number, number: "invalid token"}
        expect(response).to be_not_found
      end
    end
  end

  describe "POST #create" do
    context 'when given valid params' do 
      before do 
        expect(Messages::CreateJob).to receive(:perform_later)
      end
      it 'returns success' do 
        post :create, params: { application_token: message.chat.application.token,
          chat_number: message.chat.number, message: valid_attributes }
        expect(response).to be_successful
        expect(json[:message_number]).to be_present
      end
    end

    context 'when given invalid params' do 
      it 'returns unprocessable entity with error key' do 
        post :create, params: { application_token: message.chat.application.token,
          chat_number: message.chat.number, message: invalid_attributes }
        expect(response).to be_unprocessable
        expect(json[:content]).to be_present
      end
    end
  end
  
  describe "PUT #update" do
    context 'when given valid params' do 
      it 'returns success' do 
        post :create, params: { application_token: message.chat.application.token,
        chat_number: message.chat.number, number: message.number, message: valid_attributes }
        expect(response).to be_successful
      end
    end

    context 'when given invalid params' do 
      it 'returns unporcessable entity with error key' do 
        post :create, params: { application_token: message.chat.application.token,
          chat_number: message.chat.number, message: invalid_attributes }
        expect(response).to be_unprocessable
        expect(json[:content]).to be_present
      end
    end
  end

  describe "DELETE #delete" do
    before { message }
    context 'when given valid token' do 
      it 'returns success and deletes record from table' do 
        expect do
          delete :destroy, params: { application_token: message.chat.application.token,
            chat_number: message.chat.number, number: message.number }
        end.to change(Message, :count).by(-1)
        expect(response).to be_successful
      end
    end

    context 'when given invalid token' do
      it 'returns not found' do 
        expect do
          delete :destroy, params: { application_token: message.chat.application.token,
            chat_number: message.chat.number, number: "invalid number" }
        end.to change(Message, :count).by(0)
        expect(response).to be_not_found
      end
    end
  end
end