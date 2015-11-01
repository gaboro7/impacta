class CreatePrecioarts < ActiveRecord::Migration
  def change
    create_table :precioarts do |t|
      t.float :precio, :default => 0
      t.float :descuento, :default => 0
      t.references :comercializable, :null => false
      t.references :listaprecio, :null => false

      t.timestamps
    end
    add_index :precioarts, :comercializable_id
    add_index :precioarts, :listaprecio_id
    add_foreign_key(:precioarts, :rolarticulos, :column => 'comercializable_id')
    add_foreign_key(:precioarts, :listaprecios, :dependent => :delete)
  end
end
