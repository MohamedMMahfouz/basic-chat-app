class ApplicationController < ActionController::API
  include ExceptionsHandler

  protected

  def paginate(collection:, options: {}, render_options: {})
    collection = collection.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
    render(
     { 
       json: collection, adapter: :json
     }.merge(render_options)
    )
  end
end
