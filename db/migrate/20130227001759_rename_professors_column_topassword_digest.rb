class RenameProfessorsColumnTopasswordDigest < ActiveRecord::Migration
  def up
     rename_column :professors, :password, :password_digest
  end

  def down
     rename_column :professors, :password, :password_digest
  end

  #def change
  #  rename_column :Professors, :password, :password_digest
  #end
  
end
