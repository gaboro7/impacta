class CreateRenglonNotacreditos < ActiveRecord::Migration
  def change
    create_table :renglon_notacreditos do |t|
      t.references :notadecredito, :null => false
      t.references :factura, :null => false
      t.string :comentario
      t.float :cantidad, :null => false
      t.references :comercializable
      t.float :descuento, :default => 0
      t.float :precio_unitario, :null => false
      t.float :total_impuestos, :null => false
      t.float :total_renglon, :null => false

      t.timestamps
    end
    add_index :renglon_notacreditos, :notadecredito_id
    add_index :renglon_notacreditos, :factura_id
    add_index :renglon_notacreditos, :comercializable_id
    add_foreign_key(:renglon_notacreditos, :facturas)
    add_foreign_key(:renglon_notacreditos, :notadecreditos,  :dependent => :delete)
    add_foreign_key(:renglon_notacreditos,:rolarticulos, :column => "comercializable_id")
  end
end
