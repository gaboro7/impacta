class CreateMonedas < ActiveRecord::Migration
  def change
    create_table :monedas do |t|
      t.string :nombre, :null => false, :unique => true
      t.float :tipodecambio, :default => 0
      t.boolean :predeterminada, :default => false

      t.timestamps
    end
  end
end
