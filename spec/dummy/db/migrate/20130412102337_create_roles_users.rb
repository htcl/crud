class CreateRolesUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :roles_users, :id => false do |t|
      t.references :user
      t.references :role
    end
  end
end
