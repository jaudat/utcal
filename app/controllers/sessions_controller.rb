class SessionsController < ApplicationController
	def new
	end

	def create
	    user = User.find_by_utorid(params[:session][:utorid].downcase)
	    if user && user.authenticate(params[:session][:password])
	      sign_in user
	      student = Student.find_by_user_id(user.id)
	      professor = Professor.find_by_user_id(user.id) 
	      if !student.nil?
	      		redirect_to student

	      elsif !professor.nil?
	      		redirect_to professor
	      else
	      	flash.now[:error] = 'Incorrect data record'
	      	render 'new'
	      end
	    else
	      flash.now[:error] = 'Invalid email/password combination'
	      render 'new'
	    end
  	end

	def destroy
		sign_out
		redirect_to root_url
	end

end
