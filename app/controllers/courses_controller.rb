class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  XMLDIR = "/home/ather/Desktop/Project/utcal/utcal/CourseTimetable.xml"

  def index
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        # current_user.courses.concat(@course)
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def mystudents
    course = Course.find(params[:id])
    @list = course.enrolledincourse
    render 'mystudents'
  end

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

  #BUILD DB OF COURSES
  def builddb
    require 'nokogiri'
    require 'date'

    f= File.open(XMLDIR)
    doc = Nokogiri::XML(f)
    root = doc.root
    @course_xml = root.xpath("Row")
    @c=[]

    n = 10 # THIS IS FOR TESTING. SET TO GET n number of courses from xml
    count =0 
    @course_xml.each do |data|

      @code = data.xpath("Course_and_Section_Code")
      ##
      @section_t = @code.text
      @section = @section_t[-1,1]
      ##
      @restrictions = data.xpath("Restrictions_and_Instructions").text
      @days = data.xpath("Days").text

      date_now = Date.today
      date_tostring = date_now.to_s

      date_st1= data.xpath("Start").to_s
      date_st2= date_tostring + date_st1
      @start = date_st2.to_datetime  

      date_et1= data.xpath("End").to_s
      date_et2= date_tostring + date_et1
      @end =date_et2.to_datetime

      @location = data.xpath("Location").text
      @instruction = data.xpath("Instructor").text
      @changes = data.xpath("Changes").text

  # Course(id: integer, code: string, section: string, 
  #restrictions: string, days: string, start: datetime, 
  #end: datetime, location: string, created_at: datetime, 
  #updated_at: datetime) 
      @course_object = Course.create(:code => @code.text , :section => @section,
                      :restrictions => @restrictions, :days => @days, :start => @start, 
                       :end => @end, :location => @location)
      count = count +1

      @c.push(data)
      if count == n
        break
      end 
    end
    @c
     respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => {:xml => @c.to_xml, }}
    
    end

  end


  

end
