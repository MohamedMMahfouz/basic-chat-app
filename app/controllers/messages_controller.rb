class MessagesController < ApplicationController
  before_action :set_application 
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    @messages = @chat.messages

    paginate collection: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message = @chat.messages.new(message_params)

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private

    def set_application
      @application = Application.find_by!(token: params[:application_token])
    end

    def set_chat
      @chat = @application.chats.find_by!(number: params[:chat_number])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = @chat.messages.find_by!(number: params[:number])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:content)
    end
end
