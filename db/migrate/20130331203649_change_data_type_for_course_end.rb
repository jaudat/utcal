class ChangeDataTypeForCourseEnd < ActiveRecord::Migration
  def up
  	change_table :courses do |t|
  		t.change :end, :datetime
  	end
  end

  def down
  	change_table :courses do |t|
  		t.change :end, :time
  	end
  end
end
