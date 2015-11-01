class CreateContactos < ActiveRecord::Migration
  def change
    create_table :contactos do |t|
      t.string :nombre , :null => false
      t.string :sector
      t.integer :interno
      t.text :comentarios
      t.integer :contactable_id, :null => false
      t.string :contactable_type

      t.timestamps
    end
    add_index :contactos, :contactable_id
  end
end
