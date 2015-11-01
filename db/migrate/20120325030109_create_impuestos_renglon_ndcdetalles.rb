class CreateImpuestosRenglonNdcdetalles < ActiveRecord::Migration
  def change
    create_table :impuestos_renglon_ndcdetalles do |t|
      t.references :impuesto, :null => false
      t.references :renglon_ndcdetalle, :null => false

      t.timestamps
    end
    add_index :impuestos_renglon_ndcdetalles, :impuesto_id
    add_index :impuestos_renglon_ndcdetalles, :renglon_ndcdetalle_id
    add_foreign_key(:impuestos_renglon_ndcdetalles, :impuestos)
    add_foreign_key(:impuestos_renglon_ndcdetalles, :renglon_ndcdetalles,  :dependent => :delete)

  end
end
