class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :listing_id 
      t.date :arriving_date 
      t.date :leaving_date 
      t.text :remarks 	
      t.timestamps
    end
  end
end
