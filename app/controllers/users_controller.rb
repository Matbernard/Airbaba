class UsersController < ApplicationController

	def show
		@user = current_user
	end

  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to flats_url }
  #     format.json { head :no_content }
  #   end
  # end

end
