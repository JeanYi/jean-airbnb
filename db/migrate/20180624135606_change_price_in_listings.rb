class ChangePriceInListings < ActiveRecord::Migration[5.2]
  def change
  	change_column :listings, :price, :integer
  end
end
