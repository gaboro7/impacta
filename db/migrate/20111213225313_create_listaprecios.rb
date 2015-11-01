class CreateListaprecios < ActiveRecord::Migration
  def change
    create_table :listaprecios do |t|
      t.string :nombre, :null => false
      t.boolean :predeterminada, :default => false

      t.timestamps
    end

    add_foreign_key(:clientes, :listaprecios)
  end
end
