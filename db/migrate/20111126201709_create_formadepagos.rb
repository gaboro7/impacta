class CreateFormadepagos < ActiveRecord::Migration
  def change
    create_table :formadepagos do |t|
      t.string :nombre, :null => false
      t.enum   :estado,  :null => false
      t.boolean :predeterminada, :default => false
      t.timestamps
    end
  end
end
