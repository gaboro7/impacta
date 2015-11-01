class CreateRenglonNdcArticulos < ActiveRecord::Migration
  def change
    create_table :renglon_ndc_articulos do |t|
      t.references :comercializable, :null => false
      t.references :notadecredito, :null => false
      t.float :cantidad, :null => false

      t.float :precio_unitario, :null => false
      t.float :total_renglon, :null => false
      t.float :total_impuestos, :null => false
      t.float :descuento, :default => 0
      t.string :comentario

      t.timestamps
    end
    add_index :renglon_ndc_articulos, :comercializable_id
    add_index :renglon_ndc_articulos, :notadecredito_id
    add_foreign_key(:renglon_ndc_articulos, :notadecreditos,  :dependent => :delete)
    add_foreign_key(:renglon_ndc_articulos,:rolarticulos, :column => "comercializable_id")
  end
end
