module Api
    class RestaurantController < ApplicationController
       
        def initialize
        end

        def index
            restaurants = Restaurant.all
            render json: {status: 'Success', message: 'List oF Restaurants', data: restaurants}, status: :ok
        end
        def show
            begin
            restaurant = Restaurant.find(params[:id])
            render json: {status: 'Success', message: 'List oF Restaurants', data: restaurant}, status: :ok
            rescue Exception => e
                render json: {status: 'Error', message: 'Restaurant Not Found ', data: e}, status: :ok
            end
        end
        def create
            resto = Restaurant.new(resto_params)
            if resto.save
                render json: {status: 'Success', message: 'Restaurant Saved successfully', data:resto}, status: :ok
            else
                render json: {status: 'Error', message: 'Failed to Save Restaurant', data:resto.errors}, status: :unprocessable_entity
            end
        end
        def destroy
            begin
            restaurant = Restaurant.find(params[:id])            
            restaurant.destroy
            render json: {status: 'Success', message: 'Restaurant Deleted', data:restaurant}, status: :ok 
            rescue Exception =>e
                render json: {status: 'Error', message: 'Failed to Delete Restaurant', data:e}, status: :ok
            end 
        end
        def update
            resto = Restaurant.find(params[:id])
            if resto.update_attributes(resto_params)
                render json: {status: 'Success', message: 'Restaurant has been Updated successfully', data:resto}, status: :ok
            else
                render json: {status: 'Error', message: 'Failed to update Restaurant', data:resto.errors}, status: :unprocessable_entity
            end
        end
        def resto_params
            params.permit(:name, :rating, :address, :description)
        end

        def parse_request
            @JSON =JSON.parse(request.body.read)
        end
        def authenticate_user_from_token!
            if @JSON['token']
                render json:{success: 'Success',msg: 'Token is available', data: @JSON}, status: :ok
            else
                render json:{success: 'Error',msg: 'Token is not available', data: @JSON}, status: :unauthorised
            end
        end
        private def find_project
          @project = Restaurant.find_by_name(params[:name])
          render json:{nothing: true}, status: :not_found unless @project.present?
        end
      
    end
end