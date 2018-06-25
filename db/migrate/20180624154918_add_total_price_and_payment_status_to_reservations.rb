class AddTotalPriceAndPaymentStatusToReservations < ActiveRecord::Migration[5.2]
  def change
  	add_monetize :reservations, :total_price
  	add_column :reservations, :payment_status, :integer, default: 0 
  end
end
