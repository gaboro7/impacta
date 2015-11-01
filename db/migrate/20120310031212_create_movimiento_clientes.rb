class CreateMovimientoClientes < ActiveRecord::Migration
  def change
    create_table :movimiento_clientes do |t|
      #se retira la existencia para los saldos iniciales
      t.integer :documento_id#, :null => false
      t.string :documento_type#, :null => false
      t.references :cliente, :null => false
      t.references :sucursal
      t.string :operacion, :null => false
      t.date :fecha, :null => false
      t.float :debe, :null => false
      t.float :haber, :null => false
      t.float :saldo, :null => false
      t.references :moneda, :null => false
      t.float :debe_sucursal
      t.float :haber_sucursal
      t.float :saldo_sucursal
      t.timestamps
    end
    add_index :movimiento_clientes, :cliente_id
    add_index :movimiento_clientes, [:cliente_id, :fecha , :moneda_id], :name => "index_movimientos_clientes_reportes1"
    add_index :movimiento_clientes, [:cliente_id, :sucursal_id, :fecha , :moneda_id], :name => "index_movimientos_clientes_reportes1_con_sucursal"
    add_index :movimiento_clientes, [:documento_id, :documento_type]
  end
end
