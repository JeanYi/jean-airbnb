class Reservation < ApplicationRecord
	belongs_to :user 
	belongs_to :listing 
	validates :arriving_date, presence: true
	validates :leaving_date, presence: true
  validate :arriving_date_cannot_be_in_the_past
  validate :leaving_date_before_arriving_date?
  validate :check_overlap

  def arriving_date_cannot_be_in_the_past
    if arriving_date.present? && arriving_date < Date.today
      errors.add(:arriving_date, "can't be in the past")
    end
  end    

  def leaving_date_before_arriving_date?
    if leaving_date < arriving_date
      errors.add(:end_date, "must be on or after arriving date")
    end
  end

  def check_overlap
    dates =[]
    listing.reservations.each {|x|
      dates += (x.arriving_date...x.leaving_date).to_a}  
    
    if (dates & (self.arriving_date...self.leaving_date).to_a).count != 0
      errors.add(:overlapping_dates, "The reservation dates conflict with an existing reservation")
    end 
  end 
end 

 #  def check_overlap  
 #  	listing.reservations.each do |old_booking|
 #  		if overlap?(self, old_booking)
 #  			if self == old_booking
 #  				return true 
 #  			else 
 #  				errors.add(:overlapping_dates, "The reservation dates conflict with an existing reservation")
 #  			end 
 #  		end 
 #  	end 
 #  end

 #  X is the current booking 
 #  Y is the old bookings 

 #  def overlap?(x,y)
 #  	(x.arriving_date.day - y.leaving_date.day) * (y.arriving_date.day - x.leaving_date.day) > 0
 #  end 
