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

end
