class StaticPagesController < ApplicationController
  def home
<<<<<<< HEAD
=======

>>>>>>> fda4b1dc8f5bac02784b01699710f74a1d04f41d
  	if session[:type] == "Student"
  		student = Student.find_by_user_id(session[:remember_token])
  		redirect_to student
  	elsif session[:type] == "Professor"
  		professor = Professor.find_by_user_id(session[:remember_token])
  		redirect_to professor
  	end
  end
<<<<<<< HEAD
 
 def help
=======



  def help
>>>>>>> fda4b1dc8f5bac02784b01699710f74a1d04f41d
  end

  def about
  end

  def contact
  end
   
end
