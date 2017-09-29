require 'rails_helper'
require 'factory_girl_rails'
require_relative '../../app/controllers/api/menu_controller'
RSpec.describe Api::MenuController, type: :controller do
	 describe ".create" do
			let(:menu) { Menu.create(:name => 'Restaurants Menu', :description => 'Veg and non-veg',
			:category => "Appetizer", :restaurant_id => 1)}
			it "creats new restaurant" do
			expect(menu.errors).to be_empty
		end
			it "creats new restaurant" do
			expect(Menu.create(:name => 'Restaurants Menu').errors).to_not be_empty
		end
	end
end