class CreateClientesPromocions < ActiveRecord::Migration
  def change
    create_table :clientes_promocions do |t|
      t.references :cliente, :null  => false
      t.references :promocion, :null => false

      t.timestamps
    end

    add_index :clientes_promocions, :cliente_id
    add_index :clientes_promocions, :promocion_id
    add_foreign_key(:clientes_promocions, :clientes)
    add_foreign_key(:clientes_promocions, :promocions, :dependent => :delete)

    add_column :promocions, :descripcion, :string
    add_index :promocions, :descripcion

  end
end
