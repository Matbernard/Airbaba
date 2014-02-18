class UsersController < ApplicationController

	def show
		@user = current_user
		@flats = @user.flats
	end


	def index
	end

	private




end
