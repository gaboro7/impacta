class CreateFotoImpuestoNdds < ActiveRecord::Migration
  def change
    create_table :foto_impuesto_ndds do |t|
      t.integer :renglon_id, :null => false
      t.string :renglon_type, :null => false
      t.string :nombre, :null => false
      t.float :porcentaje, :null => false

      t.timestamps
    end

    add_index :foto_impuesto_ndds, [:renglon_id,:renglon_type]
  end
end
