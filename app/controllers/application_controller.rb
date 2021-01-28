class ApplicationController < ActionController::API
  include ExceptionsHandler
  
  # before_action :set_application

  private

  def set_application
    @application = Application.find(params[:token])
  end

  def paginate(collection:, options: {})
    collection = collection.paginate(page: params[:page], per_page: params[:per_page])
    render collection
  end
end
