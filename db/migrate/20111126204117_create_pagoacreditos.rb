class CreatePagoacreditos < ActiveRecord::Migration
  def change
    add_column :formadepagos, :cantidad, :integer
    add_column :formadepagos, :type, :string, :null => false
    add_column :formadepagos, :unidad, :string
  end
end
