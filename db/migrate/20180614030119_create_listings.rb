class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.timestamps null: false
      t.string :name
      t.string :place_type
      t.integer :room_number
      t.integer :bed_number
      t.integer :guest_number
      t.string :country
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :address
      t.decimal :price
      t.text :description
      t.integer :user_id
      t.integer :verified, default: 0 
      t.json :listing_images
    end
  end
end


#default: 0 is unverified 