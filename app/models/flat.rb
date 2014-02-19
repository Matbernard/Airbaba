class Flat < ActiveRecord::Base

	belongs_to :owner, class_name: "User"
	has_many :bookings
	has_and_belongs_to_many :tags
	has_many :pictures
	accepts_nested_attributes_for :pictures
	has_many :reviews, through: :bookings
	has_many :bookers, through: :bookings

	validates :title, presence: {:message => 'You HAVE to give a title to your flat !'}
	validates :address, presence: {:message => 'You HAVE to tell us where it is !'}
	validates :day_price, presence: {:message => "That's free ?"}
	validates :description, presence: {:message => "You HAVE to describe a bit your place !"}

end
