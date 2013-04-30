class AdminController < ApplicationController
XMLDIR_s = "/home/ather/Desktop/Project/utcal/utcal/StudentsCSV.xml"
XMLDIR_c = "/home/ather/Desktop/Project/utcal/utcal/CourseTimetable.xml"

	def index
		@user = current_user.utorid
	end

	#the following function builds the students database 
	#by reading the StudentsCSV.xml
	def buildstudents
	    require 'nokogiri'
	    require 'date'

	    
	    studentLog = File.open('StudentsLog.txt','w')
	    f= File.open(XMLDIR_s)
	    doc = Nokogiri::XML(f)
	    root = doc.root
	    @student_xml = root.xpath("Row")
	    @s = []# for testing
	    n=5# for testing
	    count=0# for testing
		    @student_xml.each do |data|
		
		    	#STUDENTS MODEL ATTRIBUTES 
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


		    	@s.push(@student_courses)# for testing
		    	# for testing
		    	 if count == n
	        		break
	      		end 

		    end
	    @s # for testing
	    
	 end


#XML sample for reference
#<Row>
#   <Course_and_Section_Code>ACMD91H3 Y</Course_and_Section_Code>
#   <Meeting_and_Section>LEC01</Meeting_and_Section>
#   <Restrictions_and_Instructions>W,C</Restrictions_and_Instructions>
#   <Days/>
#   <Start/>
#   <End/>
#   <Location>Supervised Study</Location>
#   <Instructor>Faculty</Instructor>
#   <Changes/>
# </Row>

#Course Model for reference
# Course(id: integer, code: string, section: string, 
    #restrictions: string, days: string, start: datetime, 
    #end: datetime, location: string, created_at: datetime, 
    #updated_at: datetime

  #BUILD DB OF COURSES
  def buildcourses
      require 'nokogiri'
      require 'date'

      @LogArrayCourses = []
      courseLog = File.open('CoursesLog.txt','w')
      @start_date = "2013-08-01".to_datetime
      @start_day = @start_date.strftime("%a")

      f= File.open(XMLDIR_c)
      doc = Nokogiri::XML(f)
      root = doc.root
      @course_xml = root.xpath("Row")
      @c=[]

      n = 50 # THIS IS FOR TESTING. SET TO GET n-k number of courses from xml
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
        #@check = Course.find_by_code(@code)
        # @check = Course.where("code LIKE AND meeting = ?",@code,@meeting)
#Check if course already exists
        
	        @section_t = @code_t.text
	        @section = @section_t[-1,1] 
	        ##
	        @restrictions = data.xpath("Restrictions_and_Instructions").text
	        @meeting = data.xpath("Meeting_and_Section").text

	
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
    #  respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render :json => {:xml => @c.to_xml, }}
       
    # end
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
