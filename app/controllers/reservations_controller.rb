class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:edit, :update, :show, :destroy]

def index 
	@all_reservations = Reservation.all
end 

def new
	@reservation = Reservation.new 
end 

def create 
	@reservation = current_user.reservations.new(reservation_params)
	if @reservation.save 
		redirect_to user_listing_reservations_path 
	else 
		flash[:notice] = "Something went wrong, please try again."
		render 'index'
	end 
end 

private 
	
 def reservation_params 
    params.require(:reservation).permit(:arriving_date, :leaving_date, :remarks) 
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

end
