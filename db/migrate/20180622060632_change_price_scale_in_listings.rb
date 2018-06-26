class ChangePriceScaleInListings < ActiveRecord::Migration[5.2]
  def change
  	change_column :listings, :price, :decimal, :precision => 20, :scale => 2
  end
end
