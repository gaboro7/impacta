class CreateImpresionesNdds < ActiveRecord::Migration
  def change
    create_table :impresiones_ndds do |t|
      t.boolean :anulada, :default => false
      t.integer :cant_paginas, :default => 1
      t.references :notadedebito, :null => false
      t.integer :numero, :null => false
      t.string :serie, :null => false

      t.timestamps
    end
    add_index :impresiones_ndds, :notadedebito_id
    add_index :impresiones_ndds, [:numero, :serie]
    add_foreign_key(:impresiones_ndds, :notadedebitos, :dependent => :delete)
  end
end
