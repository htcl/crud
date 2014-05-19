class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user
      t.string :forename
      t.string :surname

      t.timestamps
    end
  end
end
