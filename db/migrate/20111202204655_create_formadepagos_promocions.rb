class CreateFormadepagosPromocions < ActiveRecord::Migration
  def change
    create_table :formadepagos_promocions, :id => false do |t|
      t.references :formadepago
      t.references :promocion

      t.timestamps
    end
    add_index :formadepagos_promocions, :formadepago_id
    add_index :formadepagos_promocions, :promocion_id
    add_foreign_key(:formadepagos_promocions, :formadepagos)
    add_foreign_key(:formadepagos_promocions, :promocions,:dependent => :delete)
  end
end
