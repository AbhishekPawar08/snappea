class AuthenticateUser
    #prepend SimpleCommand
  
    def initialize(username, password)
      @username = username
      @password = password
    end
  
    def call
      JsonWebToken.encode(user_id: user.id) if user
    end
  
    private
  
    attr_accessor :username, :password
  
    def user
      user = User.find_by_username(username)
      #puts user.password if user
      p password
      p user.password
      return user if user && user.password.eql?(password) #&& user.authenticate(password)
      #errors.add :user_authentication, 'invalid credentials'
      nil
    end
  end