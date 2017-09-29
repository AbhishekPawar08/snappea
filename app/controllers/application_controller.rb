require_relative '../config/authorize_api_request'
class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user
  
    def authenticate_request
      @current_user = AuthorizeApiRequest.new(request.headers).call
      render json: { error: 'Not Authorized' , data: nil}, status: 401 unless @current_user
    end
end
