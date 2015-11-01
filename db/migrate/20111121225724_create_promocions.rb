class CreatePromocions < ActiveRecord::Migration
  def change
    create_table :promocions do |t|
      t.date :fechainicio, :null => false
      t.date :fechafin, :null => false
      t.float :descuento, :default => 0
      t.timestamps
    end
    add_index :promocions, :fechainicio
    add_index :promocions, :fechafin
  end
end

