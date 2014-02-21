class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :flats, foreign_key: 'owner_id', dependent: :destroy
  has_many :bookings, foreign_key: 'booker_id', dependent: :destroy
  has_many :reviews, through: :bookings
  has_many :booked_flats, through: :bookings, source: :flat


  validates :full_name, presence: {:message => 'You must enter your full name!'}
  validates :telephone, presence: {:message => 'You must enter your tel!'}


  def has_stayed_in?(flat)
    !last_booking_for(flat).nil?
  end

  def last_booking_for(flat)
    flat.bookings.where('booker_id == ? AND end_time <= ?', self.id, Date.today.end_of_day)
                  .where(Review.where('reviews.booking_id == bookings.id').exists.not).last
  end

end
