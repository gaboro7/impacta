class CreateEmpresas < ActiveRecord::Migration
  def change
    add_column :clientes, :nombrereal, :string
    add_column :clientes, :nombrefiscal, :string
    add_column :clientes, :nif, :string
    add_column :clientes, :dirweb, :string

  end
end
