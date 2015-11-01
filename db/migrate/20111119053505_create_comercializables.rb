class CreateComercializables < ActiveRecord::Migration
  def change
    add_column :rolarticulos, :descuento, :float , :default => 0
    add_column :rolarticulos, :garantia, :integer , :default => 0

  end
end
