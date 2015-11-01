class CreateRecibos < ActiveRecord::Migration
  def change
    create_table :recibos do |t|
      t.date :fecha, :null => false
      t.string :codigo_barras
      t.string :detalle
      t.string :rut, :null => false
      t.string :direccion_cliente, :null => false
      t.references :pagocontado , :null => false
      t.integer :comerciante_id, :null => false
      t.string :comerciante_type, :null => false
      t.references :sucursal
      t.references :moneda, :null => false
      t.string :nom_moneda
      t.float :tipo_de_cambio
      t.boolean :impresa, :default => false
      t.boolean :anulada, :default => false
      t.string :numero
      t.boolean :manual
      t.timestamps
    end
    add_index :recibos, :fecha
    add_index :recibos, :numero
    add_index :recibos, [:comerciante_id,:comerciante_type]
    add_foreign_key(:recibos, :formadepagos, :column => "pagocontado_id")
    add_foreign_key(:recibos, :monedas)
    add_foreign_key(:recibos,:sucursals)
  end
end
