class ReservationsController < ApplicationController 

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
		redirect_to your_reservations_path 
	else 
		render "new"
		flash[:notice] = "Something went wrong, please try again."	
	end 
end 

# Path = listing_reservation_path 
# GET /listings/:listing_id/reservations/:id
# def show 
# 	@listing = Listing.find(params[:listing_id])
# 	@reservation = @listing.reservations.find(params[:id])
# end 

# Path = your_reservations_path
# GET = /your_reservations 
def your_reservations 
	@your_reservations = Reservation.where(user_id: current_user.id)
	render "your_reservations"
end 

# Path = edit_listing_reservation_path 
# GET  /listings/:listing_id/reservations/:id/edit
def edit 
	@listing = Listing.find(params[:listing_id])
	@reservation = @listing.reservations.find(params[:id])
end 

# Path = listing_reservation_path 
# PATCH /listings/:listing_id/reservations/:id
def update
	@listing = Listing.find(params[:listing_id])
	@reservation = @listing.reservations.find(params[:id])
	if @reservation.update_attributes(reservation_params)
        redirect_to your_reservations_path
    else 
        render "edit"
    end 
end 

# To get the total_price for a particular reservation
# def reservation_total_price 
# 	@listing = Listing.find(params[:listing_id])
# 	@reservation = @listing.reservations.find(params[:id])
# 	@calculate_price = (@reservation.listing.price_cents * (@reservation.leaving_date - @reservation.arriving_date).to_i)
# 	@reservation.total_price_cents << @calculate_price
# 		if @reservation.save 
# 		end 

	# @total_nights = (@reservation.leaving_date - @reservation.arriving_date).to_i 
	# @calculate_price = (@reservation.listing.price_cents * @total_nights)
# end 

private 	
 def reservation_params 
    params.require(:reservation).permit(
    :arriving_date, 
    :leaving_date, 
    :remarks,
    :payment_status,
    :total_price_cents,  
    :listing_id, 
    :user_id) 
 end

end

# redirect_to listing_reservation_path(@reservation.listing_id, @reservation.id)


