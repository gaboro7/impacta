class CreateFormadepagosMonedas < ActiveRecord::Migration
  def change
    create_table :formadepagos_monedas, :id => false do |t|
      t.references :formadepago, :null => false
      t.references :moneda, :null => false

      t.timestamps
    end
    add_index :formadepagos_monedas, [:formadepago_id,:moneda_id]
    add_foreign_key(:formadepagos_monedas, :formadepagos, :dependent => :delete)
    add_foreign_key(:formadepagos_monedas, :monedas, :dependent => :delete)

  end
end
