class CreateRenglonFacturas < ActiveRecord::Migration
  def change
    create_table :renglon_facturas do |t|
      t.references :factura, :null => false
      t.float :total_renglon, :null => false
      t.float :total_impuestos, :null => false
      t.references :comercializable, :null => false
      t.float :cantidad, :null => false
      t.float :precio_unitario, :null => false
      t.float :descuento, :default => 0
      t.string :comentario
      t.timestamps
    end
    add_index :renglon_facturas, :factura_id
    add_index :renglon_facturas, :comercializable_id
    add_foreign_key(:renglon_facturas, :facturas,  :dependent => :delete)
    add_foreign_key(:renglon_facturas,:rolarticulos, :column => "comercializable_id")
  end
end
