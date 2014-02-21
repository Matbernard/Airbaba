class ReviewsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_flat

  def create
  	booking = Booking.find(params[:review][:booking_id])
  	
  	@review = booking.reviews.build(review_params)

  	if @review.save
  		respond_to do |format|
  			format.html { redirect_to @flat }
        format.js
  		end
  	end

  end


  private
  def set_flat
  	@flat = Flat.find(params[:flat_id])
  end

  def review_params
  	params.require(:review).permit(:rating, :comment)
  end

end
