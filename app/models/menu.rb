class Menu < ApplicationRecord
  belongs_to :restaurant
  	validates :name, presence: true
    validates :description, presence: true
    validates :category, presence: true
    validates :restaurant_id, presence: true
end
