class CreateTelefonos < ActiveRecord::Migration
  def change
    create_table :telefonos do |t|
      t.string :telefono
      t.integer :contelefono_id, :null => false
      t.string :contelefono_type, :null => false

      t.timestamps
    end
  end
end
