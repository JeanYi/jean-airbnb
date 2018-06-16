class ListingsController < ApplicationController
  before_action :set_listing, only: [:edit, :update, :show, :destroy]

  def index
    @listings = Listing.all.order(created_at: :desc).where(verified:0) 
  end

  def new
    @listing = Listing.new 
  end

  def create
      @listing = current_user.listings.new(listings_params)
      if @listing.save
          redirect_to listings_path
      else 
        render "new"
      end
  end

  def edit
  end

  def update 
    if @listing.update(listings_params)
        redirect_to listings_path 
    else 
        render "edit"
    end 
  end 

  def show
  end 

  def mylistings
    @listings = current_user.listings
    render "index"
  end

  def destroy
    if @listing.destroy 
      redirect_to listings_path
    else 
      redirect_to @listing  
    end 
  end

  def verify 
    if current_user.admin?
      @verify_listings = Listing.find_by_id(params[:id]).update(verified:1)
      redirect_to @verified_listings 
    end 
  end 

private 
  def listings_params 
    params.require(:listing).permit(:name, :place_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :description, :address, :price)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end 


