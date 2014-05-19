class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
      t.references :user
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :user_preferences, :user_id
  end
end
