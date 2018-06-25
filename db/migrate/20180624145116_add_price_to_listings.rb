class AddPriceToListings < ActiveRecord::Migration[5.2]
  def change
  	add_monetize :listings, :price 
  end
end
