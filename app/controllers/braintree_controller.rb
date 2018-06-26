class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:id])
  end

  def checkout
  	@reservation = Reservation.find(params[:id]) 
    @listing = @reservation.listing 
    @user = @reservation.user
    @price = @listing.price_cents 
    @numberofdays = (@reservation.arriving_date...@reservation.leaving_date).count 
    @total_price = @price * @numberofdays
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    result = Braintree::Transaction.sale(
     :amount => @total_price, 
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )

    if result.success?
      @reservation.update(total_price_cents: @total_price, payment_status:1) 
      redirect_to your_reservations_path, :flash => { :success => "Transaction successful!" }
      SendReservationEmailJob.set(wait: 20.seconds).perform_later(@user, @listing.user, @reservation)  
    else
      redirect_to your_reservations_path, :flash => { :error => "Transaction failed. Please try again." }
    end
  end

end




