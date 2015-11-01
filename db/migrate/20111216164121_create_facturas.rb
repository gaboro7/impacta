class CreateFacturas < ActiveRecord::Migration
  def change
    create_table :facturas do |t|
      t.string :rut, :null => false
      t.string :direccion_cliente, :null => false
      t.boolean :contado, :null => false
      t.string :detalle
      t.date :fecha, :null => false
      t.string :codigo_barras
      t.integer :comerciante_id, :null => false
      t.string :comerciante_type, :null => false
      t.references :sucursal
      t.references :formadepago
      t.references :moneda, :null => false
      t.string :nom_moneda
      t.float :tipo_de_cambio
      t.boolean :impresa, :default => false
      t.boolean :anulada, :default => false
      t.float :adeudo, :default => 0
      t.string :numero
      t.timestamps
    end

    add_index :facturas, [:comerciante_id, :comerciante_type]
    add_index :facturas, :formadepago_id
    add_index :facturas, :fecha
    add_index :facturas, :numero
    add_index :facturas, [:comerciante_id, :comerciante_type, :adeudo]
    add_index :facturas, [:id, :contado]
    add_foreign_key(:facturas, :formadepagos)
    add_foreign_key(:facturas, :monedas)
    add_foreign_key(:facturas, :sucursals)
  end
end
