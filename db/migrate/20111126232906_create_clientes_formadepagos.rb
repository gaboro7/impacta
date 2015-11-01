class CreateClientesFormadepagos < ActiveRecord::Migration
  def change
    create_table :clientes_formadepagos, :id => false do |t|
      t.references :cliente
      t.references :formadepago

      t.timestamps
    end
    add_index :clientes_formadepagos, :cliente_id
    add_index :clientes_formadepagos, :formadepago_id
    add_foreign_key(:clientes_formadepagos, :formadepagos)
    add_foreign_key(:clientes_formadepagos, :clientes, :dependent => :delete)
  end
end
