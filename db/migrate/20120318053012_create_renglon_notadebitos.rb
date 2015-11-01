class CreateRenglonNotadebitos < ActiveRecord::Migration
  def change
    create_table :renglon_notadebitos do |t|
      t.references :notadedebito, :null => false
      t.references :factura, :null => false
      t.string :comentario
      t.float :cantidad, :null => false
      t.references :comercializable, :null => false
      t.float :descuento, :default => 0
      t.float :precio_unitario, :null => false
      t.float :total_impuestos, :null => false
      t.float :total_renglon, :null => false

      t.timestamps
    end
    add_index :renglon_notadebitos, :notadedebito_id
    add_index :renglon_notadebitos, :factura_id
    add_index :renglon_notadebitos, :comercializable_id
    add_foreign_key(:renglon_notadebitos, :facturas)
    add_foreign_key(:renglon_notadebitos, :notadedebitos,  :dependent => :delete)
    add_foreign_key(:renglon_notadebitos,:rolarticulos, :column => "comercializable_id")
  end
end
