class CreateRenglonNddndcs < ActiveRecord::Migration
  def change
    create_table :renglon_nddndcs do |t|
      t.references :notadecredito
      t.references :notadedebito
      t.string :detalle
      t.float :total_renglon
      t.float :total_impuestos

      t.timestamps
    end
    add_index :renglon_nddndcs, :notadecredito_id
    add_index :renglon_nddndcs, :notadedebito_id
    add_foreign_key(:renglon_nddndcs,:notadedebitos,  :dependent => :delete)
    add_foreign_key(:renglon_nddndcs,:notadecreditos)

  end
end
