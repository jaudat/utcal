class RemovePasswordDigestFromProfessors < ActiveRecord::Migration
  def up
    remove_column :professors, :password_digest
  end

  def down
    add_column :professors, :password_digest, :string
  end
end
