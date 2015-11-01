class CreateComercializablesPromocions < ActiveRecord::Migration
  def change
    create_table :comercializables_promocions, :id => false do |t|
      t.references :comercializable
      t.references :promocion
      t.timestamps
    end
    add_index :comercializables_promocions, :comercializable_id
    add_index :comercializables_promocions, :promocion_id
    add_foreign_key(:comercializables_promocions, :rolarticulos, :column => 'comercializable_id',:dependent => :delete)
    add_foreign_key(:comercializables_promocions, :promocions,:dependent => :delete)
  end
end
