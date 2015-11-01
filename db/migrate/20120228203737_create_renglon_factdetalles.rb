class CreateRenglonFactdetalles < ActiveRecord::Migration
  def change
    create_table :renglon_factdetalles do |t|
      t.references :factura, :null => false
      t.string :detalle, :null => false
      t.float :total_renglon, :null => false
      t.float :total_impuestos, :null => false

      t.timestamps

    end
    add_index :renglon_factdetalles, :factura_id
    add_foreign_key(:renglon_factdetalles,:facturas)

  end
end
