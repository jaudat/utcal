require 'json'

class AssignmentsController < ApplicationController

      #GET ALL COURSES OF PROFESSOR
       def show
       		ActiveRecord::Base.include_root_in_json = true
            @user = User.find(params[:id]) 
  	    	  @course = @user.mycourses
            @assgn = Assignments.all
            @courseJSON = @course.to_json

            # respond_to do |format|
            #   format.html # index.html.erb
            #   format.json { render :json => {:course => @course}}
            # end 

            #GET ALL THE STUDENTS OF THE COURSES
               crs_std = []
              JSON.parse(@courseJSON).each do |assgn|
                @assgn_temp = Course.find(assgn["id"])
                crs_std.push(@assgn_temp.enrolledincourse) 
                @casgn_json =  crs_std.to_json 
              end
              #GET ALL STUDENT COURSES
              std_crs = []
              JSON.parse(@casgn_json).each do |stdcrs_t|

                temp_id = puts stdcrs_t["id"].to_i
                @std_crs = User.find(temp_id)
                std_crs.push(@std_crs.mycourses)
                @stdcrs_json = std_crs.to_json
              end 
            # casgn = []
            # JSON.parse(@courseJSON).each do |assgn|
            #   @assgn_temp = Course.find(assgn["id"])
            #   casgn.push(@assgn_temp) 
            #   @casgn_json = casgn.to_json 
            # end
            
            #
      

        respond_to do |format|
              format.html # index.html.erb
              format.json { render :json => {:course => @stdcrs_json}}
        end 

           
#l = Location.where(["id = ?", id]).select("name, website, city").first
   #           students = []
   #          JSON.parse(@course).each do |c|
  				 
  	# 			  #@course_student = Course.find(c["id"]) WORKS
  	# 			  @course_student = Course.find(c["id"])
  	# 			  students.push(@course_student.enrolledincourse)
  	# 			  @students = students.to_json
  				 
			# end
			#STUDENT TO COURSES
		#students_tocourse = [] #object to hold student info
		 #JSON.parse(@students).each do |s|
  				 
  	# 			  #@course_student = Course.find(c["id"]) WORKS
  	# 			  @s_id = s["id"]
  	# 			  # # @course_student = User.find(s["id"])
  	# 			  # @student_ofcourses = @course_student.mycourses
  	# 			  # students_tocourse.push(student_ofcourses)
  	# 			  # @students_json = students_tocourse.to_json
  				 
			# end



		  
       end 
	
end
