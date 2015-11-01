class CreateRolarticulos < ActiveRecord::Migration
  def change
    create_table :rolarticulos do |t|
      t.string  :type, :null => false
      t.integer :rola_id, :null => false
      t.string :rola_type, :null => false
      t.timestamps
    end
    add_index :rolarticulos, :rola_id
  end
end
