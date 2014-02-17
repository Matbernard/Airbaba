class Picture < ActiveRecord::Base

	has_attached_file :picture, :default_url
	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
	belongs_to :flat

end
