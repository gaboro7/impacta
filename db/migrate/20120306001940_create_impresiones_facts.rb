class CreateImpresionesFacts < ActiveRecord::Migration
  def change
    create_table :impresiones_facts  do |t|
      t.integer :numero, :null => false
      t.string :serie, :null => false
      t.boolean :anulada, :default => false
      t.integer :cant_paginas, :default => 1
      t.references :factura, :null => false

      t.timestamps
    end
    add_index :impresiones_facts, :factura_id
    add_index :impresiones_facts, [:numero, :serie]
    add_foreign_key(:impresiones_facts,:facturas, :dependent => :delete)

  end
end
