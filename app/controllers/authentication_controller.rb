require_relative '../config/authenticate_user'
class AuthenticationController < ApplicationController
skip_before_action :authenticate_request

def authenticate
  command = AuthenticateUser.new(params[:username], params[:password]).call
  if command
    render json: { auth_token: command }
  else
    render json: { error: 'user not authorized' }, status: :unauthorized
  end
 end
end