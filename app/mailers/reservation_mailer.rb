class ReservationMailer < ApplicationMailer
 # sender's email: 
 default from: "liddat.also.can@gmail.com"

 def booking_email(customer, host, reservation)
 	@user = customer 
 	@host = host  
 	@reservation = reservation 
    mail(to: @host.email, subject: 'A booking has been made at your listing')
 end
end


# A Mailer creates a message to be delivered via email. 
# It is like a controller 