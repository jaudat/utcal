class StaticPagesController < ApplicationController
  def home


  	if session[:type] == "Student"
  		student = Student.find_by_user_id(session[:remember_token])
  		redirect_to student
  	elsif session[:type] == "Professor"
  		professor = Professor.find_by_user_id(session[:remember_token])
  		redirect_to professor
  	end
  end

# <<<<<<< HEAD
 end
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
>>>>>>> ae91dc00b9604ad9f1369b509b2b0c355beb2b24

  def help
  end

  def about
  end

  def contact
  end
   
end
