class RenameTypeToCategory < ActiveRecord::Migration
  def up
  	rename_column :assignments, :type, :category
  end

  def down
  	rename_column :assignments, :category, :type
  end
end
