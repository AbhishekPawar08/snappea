require_relative 'restaurant_controller'
module Api
    class MenuController < ApplicationController
        def index
           begin
            menu = Menu.where("restaurant_id" => params[:restaurant_id])
            if !menu.blank?
            render json:{success:true, msg:"Menu List found for restaurant" ,data:menu }, status:200
            else
                raise 'Data Not found'
            end
           rescue Exception =>e
            render json:{success:false, msg:"Failed to retrieve data",data:e }, status:404
           end
        end
        

        def show
            begin
                menu = Menu.where({"restaurant_id": params[:restaurant_id], "id":params[:id]})
            if !menu.blank?
                render json:{success:true, msg:"Menu List found for restaurant" ,data:menu }, status:200
            else
                raise 'Data Not found'
            end
            rescue Exception => e
                render json:{success:false, msg:"Failed to retrieve data",data:e }, status:404
            end
        end

        def create
            begin
                @resto = Restaurant.find(params[:restaurant_id])
                @menu = @resto.menus.new(request_params)
                if @menu.save
                    render json:{success:true, msg:"Menu Added Successfully", data:@menu },status:200
                else 
                    render json:{success:false, msg:"Failed to Create menu", data:@menu },status:500
                end
            rescue Exception =>e
                render json:{success:false, msg:"Failed to Create menu", data:e },status:404
            end
        end

        def destroy 
            begin
                menu = Menu.find_by("restaurant_id" => params[:restaurant_id] ,"id" => params[:id] )
                if !menu.blank?
                    menu.destroy
                    render json:{success:true, msg:"Menu Deleted from the table", data:menu },status:200
                else 
                    render json:{success:false, msg:"Menu not available" },status:500
                end
            rescue Exception => e
                render json:{success:false, msg:"Deletion Failed", data:e },status:404
            end
        end

        def update
            begin
            @menu = Menu.where("restaurant_id"=>params[:restaurant_id],"id" => params[:id])           
            if !@menu.blank?
                @menu.update(request_params)
                render json:{success:true, msg:"Menu Updated Successfully", data:@menu },status:200
            else
                render json:{success:false, msg:"Failed To Update", data:@menu },status:200
            end
            rescue Exception => e
                render json:{success:false, msg:"Failed To Update", data:e },status:404
            end
        end

        private def request_params
            params.require(:menu).permit(:name, :description, :category, :tag)
        end
    end
end