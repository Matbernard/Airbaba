class Booking < ActiveRecord::Base

	belongs_to :booker, class_name: "User"
	belongs_to :flat
	has_many :reviews, dependent: :destroy
	validates :start_date, presence: {:message => "You didn't specify a start date !" }
	validates :end_time, presence: {:message => "You didn't specify an end time !" }
	validate :start_must_be_before_end_time
	validate :start_time_must_be_at_least_today
	validate :available


  def duration
    (end_time - start_date).to_i
  end

  def total_price
    ((end_time - start_date) * (self.flat.day_price)).to_i
  end

  def available
  	
  	booked_period = self.flat.bookings.map { |booking| [booking.start_date, booking.end_time]}
  	# returns array of all periods where the flat is booked
		
		booked_period.each do |period|

  		if (starts_within_booked_period?(period) || same_period?(period) || surrounds_period?(period))
  		  return errors.add(:start_date, ": Flat is already booked at this period!")
  		elsif ends_within_booked_period?(period)
  		  return errors.add(:end_time, ": Flat is already booked at this period!")
  		end
  		
  	end
  end


  private

  def start_must_be_before_end_time
    errors.add(:start_date, "must be before end time") unless
       self.start_date < self.end_time
  end 

  def start_time_must_be_at_least_today
    errors.add(:start_date, "must be from today !") unless
       self.start_date >= Time.new(Time.now.year, Time.now.month, Time.now.day)
  end 

  def starts_within_booked_period?(period)
  	(period[0] <= self.start_date) && (self.start_date < period[1])
  end

  def ends_within_booked_period?(period)
  	(period[0] < self.end_time) && (self.end_time <= period[1])
  end

  def same_period?(period)
  	(period[0] == self.start_date) && (self.end_time == period[1])
  end

  def surrounds_period?(period)
  	(period[0] > self.start_date) && (self.end_time > period[1])
  end

end