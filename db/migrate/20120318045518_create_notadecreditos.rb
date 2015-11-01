class CreateNotadecreditos < ActiveRecord::Migration
  def change
    create_table :notadecreditos do |t|
      t.boolean :anulada, :default => false
      t.boolean :es_devolucion, :default => false
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
      t.string :numero
      t.float :adeudo

      t.timestamps
    end
    add_index :notadecreditos, :sucursal_id
    add_index :notadecreditos, [:comerciante_id,:comerciante_type]
    add_index :notadecreditos, :fecha
    add_index :notadecreditos, :numero
    add_foreign_key(:notadecreditos, :sucursals)
  end
end
