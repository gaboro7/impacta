class CreateImpuestosRenglonNdcs < ActiveRecord::Migration
  def change
    create_table :impuestos_renglon_ndcs do |t|
      t.references :impuesto
      t.integer :renglon_id
      t.string :renglon_type

      t.timestamps
    end
    add_index :impuestos_renglon_ndcs, :impuesto_id
  end
end
