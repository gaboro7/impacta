class CreateRenglonRecibos < ActiveRecord::Migration
  def change
    create_table :renglon_recibos do |t|
      t.references :factura, :null => false
      t.references :recibo, :null => false
      t.float :total_renglon, :null => false
      #t.float :total_impuestos, :null => false

      t.timestamps
    end
    add_index :renglon_recibos, :recibo_id
    add_index :renglon_recibos, :factura_id
    add_foreign_key :renglon_recibos,:facturas
  end
end
