class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :utorid
      t.string :password_digest 

      t.timestamps
    end
  end
end
