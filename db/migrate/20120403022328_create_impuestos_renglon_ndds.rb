class CreateImpuestosRenglonNdds < ActiveRecord::Migration
  def change
    create_table :impuestos_renglon_ndds do |t|
      t.references :impuesto
      t.integer :renglon_id
      t.string :renglon_type

      t.timestamps
    end
    add_index :impuestos_renglon_ndds, :impuesto_id
  end
end
