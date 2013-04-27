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

  def help
  end

  def about
  end

  def contact
  end
   
end
