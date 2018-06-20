class ListingsController < ApplicationController
  before_action :set_listing, only: [:edit, :update, :show, :destroy]

  # Path = listings_path 
  # GET /listings 
  def index
    @listings = Listing.all.order(created_at: :desc).where(verified:0) 
  end

  # Path = new_listing_path 
  # GET /listings/new  
  def new
    @listing = Listing.new 
  end

  # POST /listings 
  def create
      @listing = current_user.listings.new(listings_params)
      if @listing.save
          redirect_to listings_path 
      else 
        render "new"
      end
  end

  # Path = edit_listing_path 
  # GET /listing/:id/edit 
  def edit
  end

  def update 
    if @listing.update(listings_params)
        redirect_to listings_path 
    else 
        render "edit"
    end 
  end 

  # Path = listing_path 
  # GET /listings/:id  
  def show
    @listing = Listing.find(params[:id])
  end 

  # Path = my_listings_path
  # GET /mylistings 
  def mylistings
    @listings = current_user.listings
    render "index"
  end

  # Path = listing_path 
  # DELETE /listings/:id  
  def destroy
    if @listing.destroy 
      redirect_to listings_path
    else 
      redirect_to @listing  
    end 
  end

  # def verify 
  #   if current_user.admin?
  #     @verify_listings = Listing.find_by_id(params[:id]).update(verified:1)
  #     redirect_to @verified_listings 
  #   end 
  # end 

private 
  def listings_params 
    params.require(:listing).permit(:name, :place_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :description, :address, :price, {listing_images: []})
  end

# Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end
end 


