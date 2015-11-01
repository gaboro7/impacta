class CreateImpresionesNdcs < ActiveRecord::Migration
  def change
    create_table :impresiones_ndcs do |t|
      t.boolean :anulada, :default => false
      t.integer :cant_paginas, :default => 1
      t.references :notadecredito, :null => false
      t.integer :numero, :null => false
      t.string :serie, :null => false

      t.timestamps
    end
    add_index :impresiones_ndcs, :notadecredito_id
    add_index :impresiones_ndcs, [:numero, :serie]
    add_foreign_key(:impresiones_ndcs, :notadecreditos, :dependent => :delete)
  end
end
