class CreateRenglonRecdetalles < ActiveRecord::Migration
  def change
    create_table :renglon_recdetalles do |t|
      t.references :recibo, :null => false
      t.string :detalle, :null => false
      #t.float :total_impuestos, :null => false
      t.float :total_renglon, :null => false
      t.references :factura
      t.timestamps
    end
    add_index :renglon_recdetalles, :recibo_id
    add_index :renglon_recdetalles, :factura_id
    add_foreign_key(:renglon_recdetalles,:recibos)
    add_foreign_key(:renglon_recdetalles,:facturas)
  end
end
