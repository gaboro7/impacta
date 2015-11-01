class CreateArticulosRolarticulos < ActiveRecord::Migration
  def change
    create_table :articulos_rolarticulos, :id => false do |t|
      t.references :rolarticulo
      t.references :articulo

      t.timestamps
    end
    add_index :articulos_rolarticulos, :rolarticulo_id
    add_index :articulos_rolarticulos, :articulo_id
    add_foreign_key(:articulos_rolarticulos, :articulos,:dependent => :delete)
    add_foreign_key(:articulos_rolarticulos, :rolarticulos,:dependent => :delete)
  end
end
