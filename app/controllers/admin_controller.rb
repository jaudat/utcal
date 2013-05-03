class AdminController < ApplicationController

#Directory for the students xml
XMLDIR_s = "/home/cevdet/Workbench/RubyProjects/RailProjects/utcal/StudentsCSV.xml"
#Directory for the course xml
XMLDIR_c = "/home/cevdet/Workbench/RubyProjects/RailProjects/utcal/CourseTimetable.xml"



	def index
		@user = current_user.utorid
	end

	def dashboard
		render 'dashboard'
	end

	#the following function builds the students database 
	#by reading the StudentsCSV.xml
	def buildstudents
	    require 'nokogiri'
	    require 'date'
	    @LogArrayStudent = []
	    studentLog = File.open('StudentsLog.txt','w')
	    f= File.open(XMLDIR_s)
	    doc = Nokogiri::XML(f)
	    root = doc.root
	    @student_xml = root.xpath("Row")
	    @s = []# for testing
	    n=5# for testing
	    count=0# for testing

	    @student_xml.each do |data|
	
	    	@student_courses = [] #Array to store all student courses
	    	@student_id = data.xpath("Student_ID").text	
	    	@check_student = Student.find_by_stud_no(@student_id)
	    	# if @check_student == nil
	    	@f_name = data.xpath("fname").text
	    	@l_name = data.xpath("lname").text
	    	@address = data.xpath("address").text
	    	@email = data.xpath("email").text
	    	@password = data.xpath("password").text
	    	@student_courses.push(data.xpath("Course1").text.split(";"))
	    	@student_courses.push(data.xpath("Course2").text.split(";"))
 		    @student_courses.push(data.xpath("Course3").text.split(";"))
   	    	@student_courses.push(data.xpath("Course4").text.split(";"))
   	    	@student_courses.push(data.xpath("Course5").text.split(";"))
   	    	@student_courses.push(data.xpath("Course6").text.split(";"))

   	    	#If student already exists then create new user and student
   	    	if @check_student == nil
		    	@user_object = 	User.create(:utorid => @student_id, :password => @student_id,
		    					 :password_confirmation => @student_id, :category => "Student")

		    	@user_id = @user_object.id
		    	@student_object = Student.create(:stud_no => @student_id,
		    				    :f_name => @f_name, 
		    					:l_name => @l_name,:address => @address, 
		    					:email => @email,:user_id => @user_id)
		    	log = ""
		    	log = @student_object.stud_no.to_s + " Successfully created"
		    	studentLog.write(log)
		    	@LogArrayStudent.push(log)
		    else
		    #If student already exists
		    @student_object = Student.find_by_stud_no(@student_id)
		    @user_object = @student_object.get_user
			log = "Student with student_no " + @check_student.stud_no.to_s + " already exists.
					The system will continue associating the courses"
			@LogArrayStudent.push(log)
			studentLog.puts(log)

		    end
			    	
	    	@student_courses.each do |sc|
	    		if sc.length == 1
	    			log = "Missing ; for "+ sc[0]  +". Enter data in the correct format. For example CourseCode;LectureCode;TutorialCode;PracticalCode"  
	    			studentLog.puts(log)
	    			@LogArrayStudent.push(log)
		    	else	
		    		course_code = sc.shift
		    		sc.each do |c|
		    			  @course = Course.find(:all, :conditions => ["code = ? AND meeting LIKE ?",course_code,c])
		    			  if @course != nil
		    			 	@user_object.courses << @course
		    			 	log = course_code +" User course assciation completed. For " + course_code + " and Student " + @student_id
			    			@LogArrayStudent.push(log)
		    			  else
		    			  	log = ""
		    				log = course_code +" for this meeting doesn't exist."
			    			@LogArrayStudent.push(log)
			    			log = log + ". Check syntax of CSV and the XML file. Course input
			    							should be in the following format: 
			    							Course_Code;Lecture_Code;Tutorial_code;Practical_code."
			    			studentLog.puts(log)
			    		  end
		    		end
	    		end 
	    	end
	    		
	    	@s.push(@student_courses)# for testing
	    	# for testing
	    	 if count == n
        		break
      		 end 
		end
	    @student_courses # for testing
	    
	end



  def buildcourses
      require 'nokogiri'
      require 'date'

	    @f = params[:f]
	    @w = params[:w]
	    @s = params[:s]
	    @fall = DateTime.new(params[:f]["date(1i)"].to_i, params[:f]["date(2i)"].to_i, params[:f]["date(3i)"].to_i, 00,00,00)
	    @winter= DateTime.new(params[:w]["date(1i)"].to_i, params[:w]["date(2i)"].to_i, params[:w]["date(3i)"].to_i, 00,00,00)
   	    @summer= DateTime.new(params[:s]["date(1i)"].to_i, params[:s]["date(2i)"].to_i, params[:s]["date(3i)"].to_i, 00,00,00)

      @LogArrayCourses = []
      courseLog = File.open('CoursesLog.txt','w')
       # @start_date = "2013-08-01".to_datetime
      # @start_day = @start_date.strftime("%a")

      f= File.open(XMLDIR_c)
      doc = Nokogiri::XML(f)
      root = doc.root
      @course_xml = root.xpath("Row")
      @c=[]

      n = 55 # THIS IS FOR TESTING. SET TO GET n-k number of courses from xml
      count =0 
      k = 30
      #For each element of the xml file
      #add the value to the corresponding field in
      #the database
      @course_xml.each do |data|

        @code_t = data.xpath("Course_and_Section_Code")
        ##
       	@code = @code_t.text[0,@code_t.text.length-1]
        # @check = Course.where("code = #{@code}")
        @meeting = data.xpath("Meeting_and_Section").text
        @days = data.xpath("Days").text
        date_et1= data.xpath("End").to_s
        time1= data.xpath("Start").to_s
    
        @section_t = @code_t.text
        @section = @section_t[-1,1] 
        ##
        @restrictions = data.xpath("Restrictions_and_Instructions").text
        @meeting = data.xpath("Meeting_and_Section").text
        @session = data.xpath("Session").text
        if @session == "Fall"
        	@start_date = @fall
        elsif @session == "Winter"
        	@start_date = @winter
        elsif @session == "Summer"
        	@start_date = @summer
   		end

        @set_date = getDay(@start_date, @days)
        date_tostring = @set_date.to_s

        time1= data.xpath("Start").to_s

        @start_t = date_tostring + time1
        @start = @start_t.to_datetime

        date_et1= data.xpath("End").to_s
        date_et2= date_tostring + date_et1
        @end =date_et2.to_datetime

        @location = data.xpath("Location").text
        @instruction = data.xpath("Instructor").text
        @changes = data.xpath("Changes").text

	    @check = Course.find(:all, :conditions => ["code LIKE ? AND meeting LIKE ? AND days LIKE ? AND start = ? AND end = ?",@code,@meeting,@days,@start,@end])
        if @check.empty? or @check.nil?
	      if k <= count #CONDITION FOR TESTING

		        @course_object = Course.create(:code => @code, :section => @section,
		                        :restrictions => @restrictions, :days => @days, :start => @start, 
		                         :end => @end, :location => @location, :meeting => @meeting)
		        @c.push(data)

	    		dateForLog = Time.now.to_s
	    		log = dateForLog + ": " + @code_t.text + " Successfully added"
		        @LogArrayCourses.push(log)
		        courseLog.puts
	      end
	      count = count +1#CONDITION FOR TESTING
	      if count == n#CONDITION FOR TESTING
	        break#CONDITION FOR TESTING
	      end #CONDITION FOR TESTING

	    else
	    	dateForLog = Time.now.to_s
	    	log = dateForLog + ": " + @code_t.text + " Course already exists"
	    	courseLog.puts(log)
	    	@LogArrayCourses.push(log)
	    	@check
	    end
 
    end
    @c
    render 'buildcourses'
  end

  #This function gets the day the course
  #is scheduled from the xml file and relative
  #to the start gets the date the course will start.
  def getDay(start_date, day)

    date = Date.new
     #if the day read from the xml file is SU (Sunday) then
     #get the date of the next Sunday and subtract 7 to get the 
     #new date relative to the start date
      if day == "SU"
        date=start_date.next_week(start_day = :sunday) -7
      elsif day == "MO"
         date=start_date.next_week(start_day = :monday) -7    
      elsif day =="TU"
         date=start_date.next_week(start_day = :tuesday) -7   
      elsif day == "WE"
         date=start_date.next_week(start_day = :wednesday) -7   
      elsif day =="TH"    
        date=start_date.next_week(start_day = :thursday) -7   
      elsif day =="FR"
        date=start_date.next_week(start_day = :friday) -7   
      elsif day == "SA"
         date=start_date.next_week(start_day = :saturday) -7   
     end
     date.to_date
  end






end
