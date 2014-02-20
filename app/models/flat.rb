class Flat < ActiveRecord::Base

	belongs_to :owner, class_name: "User"
	has_many :bookings, dependent: :destroy
	has_and_belongs_to_many :tags
	has_many :pictures, dependent: :destroy
	accepts_nested_attributes_for :pictures
	# has_many :reviews, through: :bookings, dependent: :destroy
	has_many :bookers, through: :bookings

	validates :title, presence: {:message => 'You HAVE to give a title to your flat !'}
	validates :address, presence: {:message => 'You HAVE to tell us where it is !'}
	validates :day_price, presence: {:message => "That's free ?"}
	validates :description, presence: {:message => "You HAVE to describe a bit your place !"}

	def belongs_to?(user)
		self.owner == user
	end

  def self.with_city(city)
  	return where('') if city.nil? or city.empty?
  	where("city LIKE ?", "%#{city}%")
  end

  def self.available(search_start_date, search_end_time)
  	return where('') if search_end_time.nil? or search_start_date.nil?		  	
  	where(
  		Booking.where("bookings.flat_id == flats.id AND bookings.start_date < ? AND bookings.end_time > ?", 
  									search_end_time, search_start_date).exists.not
  	)
  end


end
