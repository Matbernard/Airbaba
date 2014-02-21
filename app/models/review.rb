class Review < ActiveRecord::Base
	belongs_to :booking		

	RATING_MAX = 5

end
