class CreateImpuestosRenglonFactdetalles < ActiveRecord::Migration
  def change
    create_table :impuestos_renglon_factdetalles, :id => false do |t|
      t.references :impuesto, :null => false
      t.references :renglon_factdetalle, :null => false


      t.timestamps
    end
    add_index :impuestos_renglon_factdetalles, :impuesto_id
    add_index :impuestos_renglon_factdetalles, :renglon_factdetalle_id
    add_foreign_key(:impuestos_renglon_factdetalles,:impuestos)
    add_foreign_key(:impuestos_renglon_factdetalles,:renglon_factdetalles,  :dependent => :delete)
  end
end
