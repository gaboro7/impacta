class CreateArticulos < ActiveRecord::Migration
  def change
    create_table :articulos do |t|
      t.string  :type , :null => false

      t.string :nombre, :null => false, :unique => true
      t.string :descripcion
      t.timestamps
    end
  end
end
