class CalendarController < ApplicationController
before_filter :signed_in_user
before_filter :correct_user

def display
	respond_to do |format|
		format.html
	end
end
end
