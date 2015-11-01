class CreateRenglonNdddetalles < ActiveRecord::Migration
  def change
    create_table :renglon_ndddetalles do |t|
      t.string :detalle, :null => false
      t.references :notadedebito, :null => false
      t.float :total_impuestos, :null => false
      t.float :total_renglon, :null => false
      t.references :factura

      t.timestamps
    end
    add_index :renglon_ndddetalles, :notadedebito_id
    add_index :renglon_ndddetalles, :factura_id
    add_foreign_key(:renglon_ndddetalles,:notadedebitos,  :dependent => :delete)
    add_foreign_key(:renglon_ndddetalles,:facturas)

  end
end
