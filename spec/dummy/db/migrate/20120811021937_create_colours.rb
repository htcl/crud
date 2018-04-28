class CreateColours < ActiveRecord::Migration[4.2]
  def change
    create_table :colours do |t|
      t.string :name
      t.string :colour_code

      #t.timestamps :null => false
    end

    add_index :colours, :name
    add_index :colours, [:name, :colour_code], :unique => true
  end
end
