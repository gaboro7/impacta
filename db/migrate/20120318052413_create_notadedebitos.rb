class CreateNotadedebitos < ActiveRecord::Migration
  def change
    create_table :notadedebitos do |t|
      t.boolean :anulada, :default => false
      t.string :rut, :null => false
      t.string :direccion_cliente, :null => false
      t.string :codigo_barras
      t.integer :comerciante_id, :null => false
      t.string :comerciante_type, :null => false
      t.string :detalle
      t.date :fecha, :null => false
      t.references :moneda, :null => false
      t.string :nom_moneda
      t.float :tipo_de_cambio
      t.boolean :impresa, :default => false
      t.references :sucursal
      t.float :adeudo
      t.string :numero
      t.timestamps
    end
    add_index :notadedebitos, :sucursal_id
    add_index :notadedebitos, [:comerciante_id,:comerciante_type]
    add_index :notadedebitos, :fecha
    add_index :notadedebitos, :numero
    add_foreign_key(:notadedebitos, :sucursals)
  end
end
