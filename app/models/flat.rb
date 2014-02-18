class Flat < ActiveRecord::Base

	belongs_to :owner, class_name: "User"
	has_many :bookings
	has_and_belongs_to_many :tags
	has_many :pictures
	accepts_nested_attributes_for :pictures

end
