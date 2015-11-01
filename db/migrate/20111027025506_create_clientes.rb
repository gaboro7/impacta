class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string  :type, :null => false
      t.boolean :credito, :default => false
      t.float :precargo
      t.enum :urecargo
      t.integer :cantrecargo
      t.float :pdescuento, :default => 0
      t.boolean :habilitado, :default => true
      t.references :listaprecio
      t.references :tipocliente
      t.string :domicilio, :null => false
      t.string :departamento
      t.string :barrio
      t.timestamps
    end
    add_index :clientes, :tipocliente_id
    add_index :clientes, :listaprecio_id

  end
end
