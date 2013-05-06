class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user2 = User.new(utorid: params[:user][:utorid], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    if @user2.save
      #TODO get user type then redirect to appropriate page
      if @user.category == "Student"
        @student = Student.new(user_id: @user2.id, f_name: @user2.utorid ,email: "my_email@utoronto.com")
        #url_for(:only_path => true, :controller => 'professor', :action => show, :id => @user.id)
        if @student.save
          sign_in @user2
          flash[:success] = "Welcome to UTCal"
          redirect_to @student
        else
          render 'new'
        end
      elsif @user.category == "Professor"
        @professor = Professor.new(user_id: @user2.id, f_name: @user2.utorid, email: "my_email@utoronto.com")
        #url_for(:only_path => true, :controller => 'professor', :action => show, :id => @user.id)
        if @professor.save
          sign_in @user2
          flash[:success] = "Welcome to UTCal"
          redirect_to @professor   
        else
          render 'new'
        end
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
  end
  
  def mycourselist
    @courses = current_user.mycourses
    render 'mycourses'
  end

  #Makes single array
  def makeArray(arr)
      @temp_arr =[]
      arr.each do |arr1|
        arr1.each do |arr2|
          @temp_arr.push(arr2)
        end  
      end
      @temp_arr
  end

  #Counts duplicates of a in course array
  def removeDupes(arr)
    #removing duplicate assignments
    @final = []
    arr.each do |u|
        c = @final.find_all {|e| e == u}.size
        lgth = arr.find_all {|e| e == u}.size
        x = u
        x.code = x.code + "#" +lgth.to_s()
       
	      @final.push(x) unless c > 0
    end 
    @final
  end
	
  def removeAsgn(arr)
   @final = []
   arr.each do |u|
 	c = @final.find_all {|e| e == u}.size
   	lgth = arr.find_all {|e| e == u}.size
   	x = u
   	x.title = x.title + "(" +lgth.to_s()+")"
        @final.push(x) unless c > 0
    end
    @final	
  end

  #get the students of a particular course
  #and their courses and then there assignments
  def mystudents_courses
    @courses = Course.find(params[:id])
    @crs_arr  = []
    @asgn_arr = []
    @std_arr = []
    @temp_tutorials = []

    #get the students of the course
    @temp_students = @courses.std_crs
    @std_arr.push(@temp_students)
    #for each of the students get their assignments
    #and the their tutorials
    @temp_students.each do |s|
      @user = s.get_user
      @temp_crs = @user.mycourses
      @crs_arr.push(@temp_crs)
      @temp_crs.each do |c|
        @asgn_arr.push(c.get_assignments)
        @temp_tutorials.push(c.getTutorials)
      end

    end
    #the return arrays made have duplicate entries
    #remove the duplicates and add tag to get
    #number of duplicate etnries
    @courses_t = makeArray(@crs_arr)
   
    @assignments_t= makeArray(@asgn_arr)
    @tutorials_t = makeArray(@temp_tutorials).uniq 
    #@assignments=makeArray(@asgn_arr).uniq
    
    @courses = removeDupes(@courses_t).uniq
    @assignments = removeAsgn(@assignments_t).uniq
    @tutorials = removeDupes(@tutorials_t).uniq   
    @students =makeArray(@std_arr)
    render 'students_courses'

  end

  def courseasgns
    @course = Course.find(params[:id])
    @asgns = @course.get_assignments
     render 'students_courses'

  end

  


end
