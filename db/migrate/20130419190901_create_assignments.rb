class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :category
      t.text :description
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
