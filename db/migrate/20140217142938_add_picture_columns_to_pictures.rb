class AddPictureColumnsToPictures < ActiveRecord::Migration

	def change
    add_attachement :picture
	end

end