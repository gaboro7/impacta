class CreateFotoImpuestoRecs < ActiveRecord::Migration
  def change
    create_table :foto_impuesto_recs do |t|
      t.string :nombre, :null => false
      t.float :porcentaje, :null => false
      t.references :renglon_recdetalle, :null => false

      t.timestamps
    end
    add_index :foto_impuesto_recs, :renglon_recdetalle_id
    add_foreign_key(:foto_impuesto_recs, :renglon_recdetalles)
  end
end
