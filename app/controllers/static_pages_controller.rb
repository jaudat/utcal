class StaticPagesController < ApplicationController
  def home

<<<<<<< HEAD




=======
>>>>>>> df5ff1420cf6a9dae89a81184c89353f83559b3a
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
>>>>>>> df5ff1420cf6a9dae89a81184c89353f83559b3a

  def help
  end

  def about
  end

  def contact
  end
   
end
