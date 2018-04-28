class CreateUserProfiles < ActiveRecord::Migration[4.2]
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user
      t.string :forename
      t.string :surname

      t.timestamps :null => false
    end
  end
end
