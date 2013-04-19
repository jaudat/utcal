class CreateAssignmentsCoursesJoinTable < ActiveRecord::Migration
  def change
  	create_table :assignments_courses, :id => false do |t|
  		t.integer :course_id
  		t.integer :assignment_id
  	end
  end
end
