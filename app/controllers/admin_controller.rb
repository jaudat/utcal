class AdminController < ApplicationController

	def index
		@user = current_user.utorid
	end


end
