class CreateImpuestosRenglonNdddetalles < ActiveRecord::Migration
  def change
    create_table :impuestos_renglon_ndddetalles do |t|
      t.references :impuesto, :null => false
      t.references :renglon_ndddetalle, :null => false

      t.timestamps
    end
    add_index :impuestos_renglon_ndddetalles, :impuesto_id
    add_index :impuestos_renglon_ndddetalles, :renglon_ndddetalle_id
    add_foreign_key(:impuestos_renglon_ndddetalles, :impuestos)
    add_foreign_key(:impuestos_renglon_ndddetalles, :renglon_ndddetalles,  :dependent => :delete)

  end
end
