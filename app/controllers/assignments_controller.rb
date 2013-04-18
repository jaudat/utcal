require 'json'

class AssignmentsController < ApplicationController

  #GET ALL COURSES OF PROFESSOR
   def show
    ActiveRecord::Base.include_root_in_json = true
      @user = User.find(params[:id]) 
      @course = @user.mycourses #Professor courses
      @assgn = Assignments.all
      @courseJSON = @course.to_json

      #GET ALL THE STUDENTS OF THE COURSES

        #For each of professors courses
        JSON.parse(@courseJSON).each do |std_crs|
          #get the students of the courses
          @std_crs = Course.find(std_crs["id"])
          @std = @std_crs.enrolledincourse

            #get students courses
            @std.each do |c|
              @std_crs2 = c.mycourses
              #get for those courses the assignments  
              @std_crs2.each do |crs2|
                @getcrs = crs2.get_assignments

              end
            end 
        end
 

    respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => {:assignments =>  @getcrs}}
    end 

          

      
       end 
  
end
