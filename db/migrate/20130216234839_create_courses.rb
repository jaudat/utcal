class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :section
      t.string :restrictions
      t.string :days
      t.time :start
      t.time :end
      t.string :location

      t.timestamps
    end
  end
end
