class AddMeetingColumnToCourses < ActiveRecord::Migration
  def change
  	change_table :courses do |t|
  		t.string :meeting
  	end
  end
end
