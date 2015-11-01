class CreateComercializablesImpuestos < ActiveRecord::Migration
  def change
    create_table :comercializables_impuestos, :id => false do |t|
      t.references :comercializable, :polymorphic => {:default => 'Rolarticulo'}
      t.references :impuesto

      t.timestamps
    end
    add_index :comercializables_impuestos, :comercializable_id
    add_index :comercializables_impuestos, :impuesto_id
    add_foreign_key(:comercializables_impuestos, :rolarticulos, :column => 'comercializable_id', :dependent => :delete)
    add_foreign_key(:comercializables_impuestos, :impuestos)
  end
end
