class Booking < ActiveRecord::Base

	belongs_to :booker, class_name: "User"
	belongs_to :flat
	has_many :reviews
	validates :start_date, presence: {:message => "You didn't specify a start date !" }
	validates :end_time, presence: {:message => "You didn't specify an end time !" }

end
