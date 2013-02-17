class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :stud_no
      t.primary_key :stud_no
      t.string :f_name
      t.string :l_name
      t.text :address
      t.string :email

      t.timestamps
    end
  end
end
