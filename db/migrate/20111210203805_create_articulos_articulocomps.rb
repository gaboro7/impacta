class CreateArticulosArticulocomps < ActiveRecord::Migration
  def change
    create_table :articulos_articulocomps do |t|
      t.references :articulo
      t.references :articulocomp

      t.timestamps
    end
    add_index :articulos_articulocomps, [:articulo_id, :articulocomp_id], :name => 'articulos_articulos_compuestos'
    add_foreign_key(:articulos_articulocomps, :articulos)
  end
end
