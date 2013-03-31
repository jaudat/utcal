require 'json'

class AssignmentsController < ApplicationController


       def show
       		ActiveRecord::Base.include_root_in_json = false
            @user = User.find(params[:id]) 
  	    	@course = @user.mycourses
            @assgn = Assignments.all
            @course = @course.to_json	
            course = @course.to_json
           
#l = Location.where(["id = ?", id]).select("name, website, city").first
             students = []
            JSON.parse(@course).each do |c|
  				 
  				  #@course_student = Course.find(c["id"]) WORKS
  				  @course_student = Course.find(c["id"])
  				  students.push(@course_student.enrolledincourse)
  				  @students = students.to_json
  				 
			end
			#STUDENT TO COURSES
			# students_tocourse = [] #object to hold student info
			# JSON.parse(@students).each do |s|
  				 
  	# 			  #@course_student = Course.find(c["id"]) WORKS
  	# 			  @s_id = s["id"]
  	# 			  # # @course_student = User.find(s["id"])
  	# 			  # @student_ofcourses = @course_student.mycourses
  	# 			  # students_tocourse.push(student_ofcourses)
  	# 			  # @students_json = students_tocourse.to_json
  				 
			# end



		    respond_to do |format|
		    format.html # index.html.erb
		    format.json { render :json => {:course => @students}}
            end 
       end 
	
end
