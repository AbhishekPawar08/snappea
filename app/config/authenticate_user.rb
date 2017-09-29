require_relative 'json_web_token'

class AuthenticateUser < ApplicationController
  skip_before_action :authenticate_request

    def initialize(username, password)
      @username = username
      @password = password
    end
  
    def call
      user
    end

    def user  
      begin
        p password
      @user = User.find_by({"username":username,"password":password})
      if !@user.nil? && !@user.blank? 
       jwt = JsonWebToken.encode(user_id: @user.id) 
       @user.update_attributes(:auth_token => jwt)
     else
        raise "Error user not found"
     end
       rescue Exception => e
       return e
      end
    end
    private
    attr_accessor :username, :password
  end
