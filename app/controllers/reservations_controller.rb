class ReservationsController < ApplicationController
  before_action :set_listing, only: [:edit, :destroy]

# Path = new_listing_reservation_path 
# GET /listings/:listing_id/reservations/new
def new
	@listing = Listing.find(params[:listing_id])
	@reservation = Reservation.new 
end 

# Path = listing_reservations_path 
# POST /listings/:listing_id/reservations
def create 
	@listing = Listing.find(params[:listing_id])
	@reservation = current_user.reservations.new(reservation_params)
	@listing.reservations << @reservation
	if @reservation.save 
		redirect_to listing_reservation_path(id: @reservation.id)
	else 
		flash[:notice] = "Something went wrong, please try again."	
		redirect_to new_listing_reservation_path
	end 
end 

# Path = edit_listing_reservation_path 
# GET  /listings/:listing_id/reservations/:id/edit
def edit 
	@reservation = @listing.reservations
end 

# Path = listing_reservation_path 
# PATCH /listings/:listing_id/reservations/:id
def update
	@listing = Listing.find(params[:listing_id])
	if @listing.reservation.update(reservation_params)
        redirect_to listing_reservation_path 
    else 
        render "edit"
    end 
end 

# Path = listing_reservation_path 
# GET /listings/:listing_id/reservations/:id 
def show
	@listing = Listing.find(params[:listing_id])
	@reservation = @listing.reservations
end 

# Path = listing_reservation_path 
# GET /listings/:listing_id/reservations/:id
def destroy
	@reservation = @listing.reservations(id: @reservation.id)
    if @reservation.destroy 
      redirect_to listing_reservation_path(id: @reservation.id)
    end 
end

def your_reservations 
	@your_reservations = Reservation.where(user_id: current_user.id)
end 

private 	
 def reservation_params 
    params.require(:reservation).permit(:arriving_date, :leaving_date, :remarks) 
 end

# Use callbacks to share common setup or constraints between actions.
 def set_listing
    @listing = Listing.find(params[:listing_id])
 end

end

# Another way to show the reservations 
# @reservation = Reservation.find(params[:id])
# @reservation.listing.reservations
