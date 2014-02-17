class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		# @flats = @user.flats
	end


	def index
	end

	private




end
