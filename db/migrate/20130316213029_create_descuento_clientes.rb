class CreateDescuentoClientes < ActiveRecord::Migration
  def change
    create_table :descuento_clientes do |t|
      t.references :cliente, :null => false
      t.references :comercializable, :null => false
      t.float :descuento, :null => false

      t.timestamps
    end
    add_index :descuento_clientes, :cliente_id
    add_index :descuento_clientes, :comercializable_id
    add_foreign_key( :descuento_clientes, :clientes)
    add_foreign_key( :descuento_clientes, :rolarticulos, :column => "comercializable_id" )

  end
end
