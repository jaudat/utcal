class AssignmentsController < ApplicationController
  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.json
  def new
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.json
  def create
    c = Course.find(params[:course_id])
    @assignment = Assignment.new(params[:assignment])

    respond_to do |format|
      if c.assignments.create(params[:assignment])
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.json
  def update
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :no_content }
    end
  end

#GETS ALL ASSIGNMENTS OF PROFESSORS STUDENTS
#   def studinfo 
#     ActiveRecord::Base.include_root_in_json = true
#     @getcrs =[]
#     # @course_stats = Hash.new
#     @std_stats = Hash.new
#     @user = current_user
#     @course = @user.mycourses #Professor courses
#     @courseJSON = @course.to_json
#     @getcrs= []
#      JSON.parse(@courseJSON).each do |std_crs|
#       #get the students of the courses
#       @std_crs = Course.find(std_crs["id"])
#       @std = @std_crs.enrolledincourse
      
#         #get students courses enrolled in course
#       @std.each do |c|
#         @std_crs2 = c.mycourses
#           #get for those courses the assignments  
#         i=1
#         @std_crs2.each do |crs2|
#           key_std=c.id.to_s
#           @std_stats[key_std] = i
#           i=i+1
#           @getcrs.push(crs2.get_assignments)
#         end
#       end 
#     end


# #REFINING THE LIST 
#   #make the getcrs in to one array
#   @stdassgns =[]
#   @getcrs.each do |gc1|
#     gc1.each do |gc2|
#       @stdassgns.push(gc2)
#     end  
#   end

#   #removing duplicate assignments
#   @final = []
#   @stdassgns.each do |u|
#       c = @final.find_all {|e| e == u}.size
#       lgth = @stdassgns.find_all {|e| e == u}.size
#       x = u
#       temp_id = x.id
#       temp_id_str = temp_id.to_s
#       temp_id_str = temp_id.to_s + "#" + lgth.to_s()
#       temp_id = temp_id_str.to_i
#       x.id = temp_id
#       # x.id = x.id + "#" + lgth.to_s()
#       @final.push(x) unless c > 0
#   end 

#   @final
#   end

#   def courseasgns


#     ActiveRecord::Base.include_root_in_json = true
#     @getcrs =[]
#     @tuts = []
#     @course_stats = Hash.new
#     @std_stats = Hash.new
#     @user = current_user
#     @course = @user.mycourses #Professor courses
#     @courseJSON = @course.to_json
#     @getcrs= []
#      # JSON.parse(@courseJSON).each do |std_crs|
#       #get the students of the courses
#       @std_crs = Course.find(params[:id])
#       @coursename = @std_crs.code
#       @std = @std_crs.enrolledincourse
#         #get students courses enrolled in course
#       @std_tojson = @std.to_json
#       @std.each do |c|
#         @std_crs2 = c.mycourses
#           #get for those courses the assignments  
#         i=1
#         @std_crs2.each do |crs2|
#           key_std=c.id.to_s
#           @std_stats[key_std] = i
#           i=i+1
#           @getcrs.push(crs2.get_assignments)
#         end
#       end 
     


# #REFINING THE LIST 
#   #make the getcrs in to one array
#   @stdassgns =[]
#   @getcrs.each do |gc1|
#     gc1.each do |gc2|
#       @stdassgns.push(gc2)
#     end  
#   end

#   #removing duplicate assignments
#   @final = []
#   @stdassgns.each do |u|
#       c = @final.find_all {|e| e == u}.size
#       lgth = @stdassgns.find_all {|e| e == u}.size
#       x = u
#       temp_id = x.id
#       temp_id_str = temp_id.to_s
#       temp_id_str = temp_id.to_s + "#" + lgth.to_s()
#       temp_id = temp_id_str.to_i
#       x.id = temp_id
#       # x.id = x.id + "#" + lgth.to_s()
#       @final.push(x) unless c > 0
#   end 

  
#   #Getting tutorials and practicals of the courses



#   @final
#   @tut

#   end

  def profassgns
    @assignment = Assignment.new
    @user_assgns = current_user
    @get_assgn = @assignment.profassgns2(@user_assgns)
  end

end
