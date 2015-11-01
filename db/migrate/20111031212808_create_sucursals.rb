class CreateSucursals < ActiveRecord::Migration
  def change
    create_table :sucursals do |t|
      t.string :nombre , :null => false
      t.string :domicilio, :null => false
      t.string :departamento
      t.string :barrio
      t.integer :empresa_id, :null => false
      t.string :observacion
      t.timestamps
    end
    add_index :sucursals, :empresa_id
    add_foreign_key(:sucursals, :clientes, :column => :empresa_id, :dependent => :delete)
  end
end
