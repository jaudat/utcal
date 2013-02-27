class RenameStudentsColumnTopasswordDigest < ActiveRecord::Migration
  def up
     rename_column :students, :password, :password_digest
  end

  def down
     rename_column :students, :password, :password_digest
  end
end
