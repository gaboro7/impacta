class CreateFotoImpuestoFacts < ActiveRecord::Migration
  def change
    create_table :foto_impuesto_facts do |t|
      t.string :nombre, :null => false
      t.float :porcentaje, :null => false
      t.integer :renglon_id, :null => false
      t.string :renglon_type, :null => false
      t.timestamps
    end
  end
end
