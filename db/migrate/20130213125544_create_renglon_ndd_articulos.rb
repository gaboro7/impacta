class CreateRenglonNddArticulos < ActiveRecord::Migration
  def change
    create_table :renglon_ndd_articulos do |t|
      t.references :notadedebito, :null => false
      t.references :comercializable, :null => false
      t.float :cantidad, :null => false
      t.float :precio_unitario, :null => false
      t.float :total_renglon, :null => false
      t.float :total_impuestos, :null => false
      t.float :descuento, :default => 0
      t.string :comentario

      t.timestamps
    end
    add_index :renglon_ndd_articulos, :comercializable_id
    add_index :renglon_ndd_articulos, :notadedebito_id
    add_foreign_key(:renglon_ndd_articulos, :notadedebitos,  :dependent => :delete)
    add_foreign_key(:renglon_ndd_articulos,:rolarticulos, :column => "comercializable_id")
  end
end
