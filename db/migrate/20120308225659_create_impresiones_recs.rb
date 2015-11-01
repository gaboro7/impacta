class CreateImpresionesRecs < ActiveRecord::Migration
  def change
    create_table :impresiones_recs do |t|
      t.integer :numero, :null => false
      t.string :serie, :null => false
      t.boolean :anulada, :default => false
      t.integer :cant_paginas, :default => 1
      t.references :recibo, :null => false

      t.timestamps
    end
    add_index :impresiones_recs, :recibo_id
    add_index :impresiones_recs, [:numero, :serie]
    add_foreign_key(:impresiones_recs, :recibos, :dependent => :delete)
  end
end
