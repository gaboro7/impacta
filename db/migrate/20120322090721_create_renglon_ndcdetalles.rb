class CreateRenglonNdcdetalles < ActiveRecord::Migration
  def change
    create_table :renglon_ndcdetalles do |t|
      t.string :detalle, :null => false
      t.references :notadecredito, :null => false
      t.float :total_impuestos, :null => false
      t.float :total_renglon, :null => false
      t.references :factura
      t.timestamps
    end
    add_index :renglon_ndcdetalles, :notadecredito_id
    add_index :renglon_ndcdetalles, :factura_id
    add_foreign_key(:renglon_ndcdetalles,:notadecreditos,  :dependent => :delete)
    add_foreign_key(:renglon_ndcdetalles,:facturas)
  end
end
