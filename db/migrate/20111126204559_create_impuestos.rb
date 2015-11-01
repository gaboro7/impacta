class CreateImpuestos < ActiveRecord::Migration
  def change
    create_table :impuestos do |t|
      t.string :nombre, :null => false , :unique => true
      t.float :porcentajea, :null => false
      t.float :porcentajec, :default => 0

      t.timestamps
    end
  end
end
