
module Api
    class UserController < ApplicationController
    def index
        userlist = User.all
        render json:{success: true, msg: "List of Users", data: userlist },status:200
    end

    def show 
        begin
        user = User.find(params[:id])  
        if !user.blank? && !user.nil?
        render json:{success: true, msg: "List of Users", data: user },status:200
        else
            raise "Data not found for = #{ params[:id] }"
        end
        rescue Exception => e
            render json:{success: false, msg: "Failed To get User Details", data: e },status:404
        end
    end

    def create
        begin
        user = User.new(user_params)
        if user.save
            render json: {success: true, message: 'User has been Added successfuly', data: user}, status:200
        else
            render json: {success: false, message: 'Failed To get User Details', data:user.errors}, status: :unprocessable_entity
        end
        rescue Exception =>e
            render json: {success: false, message: 'Failed To Add User Details', data:e}, status:500
        end
    end

    def destroy
        begin
            user = User.find(params[:id])
            if user.destroy
                render json: {success: true, message: 'User has been Added successfuly', data: user}, status:200
            else
                raise 'Error in Deleting user'
            end
         rescue Exception =>e
             render json: {success: false, message: 'Failed to Delete user', data:e}, status:500
         end
    end

    def update
        begin
            user = User.find(params[:id])
            if user.update(user_params)
                render json: {success: true, message: 'User has been Updated successfuly', data: user}, status:200
            else
                render json: {success: false, message: 'Failed to Update User', data:user.errors}, status:422 # :unprocessable_entity
            end
         rescue Exception =>e
             render json: {success: false, message: 'Failed to update user', data:e}, status:500
         end
    end

    private 
      def user_params
        params.require(:user).permit(:username, :password, :address, :mobile, :email)
      end

end
end