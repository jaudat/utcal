class ChangeDataTypeForCourseStart < ActiveRecord::Migration
  def up
  	change_table :courses do |t|
  		t.change :start, :datetime
  	end
  end

  def down
  	change_table :courses do |t|
  		t.change :start, :time
  	end
  end
end
