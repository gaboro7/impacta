class CreateRenglonNdcndds < ActiveRecord::Migration
  def change
    create_table :renglon_ndcndds do |t|
      t.references :notadecredito
      t.references :notadedebito
      t.string :detalle
      t.float :total_renglon
      t.float :total_impuestos

      t.timestamps
    end
    add_index :renglon_ndcndds, :notadecredito_id
    add_index :renglon_ndcndds, :notadedebito_id
    add_foreign_key(:renglon_ndcndds,:notadecreditos,  :dependent => :delete)
    add_foreign_key(:renglon_ndcndds,:notadedebitos)

  end
end
