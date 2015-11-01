class CreateImpresiones < ActiveRecord::Migration
  def change
    create_table :impresiones do |t|
      t.boolean :anulada, :default => false
      t.integer :cant_paginas, :default => 1
      t.integer :imprimible_id, :null => false
      t.string :imprimible_type, :null => false
      t.boolean :contado
      t.integer :numero, :null => false
      t.string :serie, :null => false

      t.timestamps
    end

    add_index :impresiones, [:imprimible_id, :imprimible_type, :numero, :serie], :name => "impresiones_indice"
    add_index :impresiones, [:imprimible_id, :imprimible_type]
    add_index :impresiones, [:imprimible_id, :imprimible_type, :contado], :name => "impresiones_indice_contado"
  end
end
