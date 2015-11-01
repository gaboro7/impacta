class CreateImpuestosRenglonRecdetalles < ActiveRecord::Migration
  def change
    create_table :impuestos_renglon_recdetalles, :id => false do |t|
      t.references :impuesto, :null => false
      t.references :renglon_recdetalle, :null => false

      t.timestamps
    end
    add_index :impuestos_renglon_recdetalles, :impuesto_id
    add_index :impuestos_renglon_recdetalles, :renglon_recdetalle_id
    add_foreign_key(:impuestos_renglon_recdetalles,:impuestos)
    add_foreign_key(:impuestos_renglon_recdetalles,:renglon_recdetalles,  :dependent => :delete)
  end
end
