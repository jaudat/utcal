class StaticPagesController < ApplicationController
  def home
<<<<<<< HEAD
=======


>>>>>>> 58a941eedc275cfeae714cb9ffc0158fea5a8cc4
  	if session[:type] == "Student"
  		student = Student.find_by_user_id(session[:remember_token])
  		redirect_to student
  	elsif session[:type] == "Professor"
  		professor = Professor.find_by_user_id(session[:remember_token])
  		redirect_to professor
  	end
  end

<<<<<<< HEAD
=======
# <<<<<<< HEAD

# =======
#   	if session[:type] == "Student"
#   		student = Student.find_by_user_id(session[:remember_token])
#   		redirect_to student
#   	elsif session[:type] == "Professor"
#   		professor = Professor.find_by_user_id(session[:remember_token])
#   		redirect_to professor
#   	end
#   end
# >>>>>>> 6d590316c7ceeff9c2bb7c495ef665c04082dab5
>>>>>>> 58a941eedc275cfeae714cb9ffc0158fea5a8cc4

  def help
  end

  def about
  end

  def contact
  end
   
end
