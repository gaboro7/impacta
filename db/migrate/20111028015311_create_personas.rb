class CreatePersonas < ActiveRecord::Migration
  def change
    add_column :clientes, :nombre, :string, :null => false
    add_column :clientes, :nic, :string
  end
end
