class CreateTipoclientes < ActiveRecord::Migration
  def change
    create_table :tipoclientes do |t|
      t.string :nombre, :null => false, :unique => true
      t.timestamps
    end
    add_foreign_key(:clientes, :tipoclientes)
  end
end
