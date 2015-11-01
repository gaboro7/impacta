class CreateDomicilios < ActiveRecord::Migration
  def change
    create_table :domicilios do |t|
      t.string :domicilio
      t.integer :persona_id

      t.timestamps
    end
  end
end
