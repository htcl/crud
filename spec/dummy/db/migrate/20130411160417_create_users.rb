class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email

      t.datetime :confirmed_at

      t.timestamps :null => false
    end
  end
end
