class AdminController < ApplicationController
XMLDIR_s = "/home/ather/Desktop/Project/utcal/utcal/StudentsCSV.xml"

	def index
		@user = current_user.utorid
	end

	def buildstudents
	    require 'nokogiri'
	    require 'date'

	    f= File.open(XMLDIR_s)
	    doc = Nokogiri::XML(f)
	    root = doc.root
	    @student_xml = root.xpath("Row")
	    @s = []
	    n=5
	    count=0
	    @student_xml.each do |data|
	    	# Student(id: integer, stud_no: integer, 
	    	# f_name: string, l_name: string, address: 
	    	# text, email: string, created_at: datetime, updated_at: datetime, user_id: integer) 
	    	# User attr_accessible :utorid, :password, :password_confirmation, :typ
	    	@student_courses = []
	    	@student_id = data.xpath("Student_ID").text	
	    	@f_name = data.xpath("fname").text
	    	@l_name = data.xpath("lname").text
	    	@address = data.xpath("address").text
	    	@email = data.xpath("email").text
	    	@password = data.xpath("password").text
	    	@student_courses.push(data.xpath("Course1").text)
	    	@student_courses.push(data.xpath("Course2").text)
 		    @student_courses.push(data.xpath("Course3").text)
   	    	@student_courses.push(data.xpath("Course4").text)
   	    	@student_courses.push(data.xpath("Course5").text)
   	    	@student_courses.push(data.xpath("Course6").text)

	    	@user_object = 	User.create(:utorid => @student_id, :password => @student_id,
	    					 :password_confirmation => @student_id, :category => "Student")

	    	@user_id = @user_object.id
	    	@student_object = Student.create(:stud_no => @student_id,
	    				    :f_name => @f_name, 
	    					:l_name => @l_name,:address => @address, 
	    					:email => @email,:user_id => @user_id)

	    	@student_courses.each do |sc|
	    		@course = Course.where("code = ?",sc)
	    		@user_object.courses << @course
	    	end


	    	@s.push(@student_courses)
	    	 if count == n
        		break
      		end 

	    end
	    @s
	    
	 end




end
