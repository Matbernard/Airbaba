class PagesController < ApplicationController

	def home
		@flats = Flat.all
		@user = current_user
	end

	def index
		
	end

end