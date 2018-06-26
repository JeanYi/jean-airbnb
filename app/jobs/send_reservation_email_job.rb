class SendReservationEmailJob < ApplicationJob
  queue_as :default

  def perform(*args) 
    ReservationMailer.booking_email(args[0], args[1], args[2]).deliver_later  
  end
  
end
