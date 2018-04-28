class CreateUserPreferences < ActiveRecord::Migration[4.2]
  def change
    create_table :user_preferences do |t|
      t.references :user
      t.string :key
      t.string :value

      t.timestamps :null => false
    end
    add_index :user_preferences, :user_id
  end
end
