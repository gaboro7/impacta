class CreateRenglonReciboDocs < ActiveRecord::Migration
  def change
    create_table :renglon_recibo_docs do |t|
      t.references :recibo, :null => false
      t.integer :documento_id, :null => false
      t.string :documento_type, :null => false
      t.float :total_renglon , :null => false
      #t.float :total_impuestos, :null => false
      t.string :detalle

      t.timestamps
    end
    add_index :renglon_recibo_docs, :recibo_id
    add_index :renglon_recibo_docs, [:documento_id, :documento_type]
    add_foreign_key(:renglon_recibo_docs, :recibos,  :dependent => :delete)

  end
end
