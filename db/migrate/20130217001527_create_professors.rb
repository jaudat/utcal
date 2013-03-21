class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :f_name
      t.string :l_name
      t.string :email

      t.timestamps
    end
  end
end