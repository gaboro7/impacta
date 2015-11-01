class CreateCelularcons < ActiveRecord::Migration
  def change
    create_table :celularcons do |t|
      t.string :cellular, :null => false

      t.timestamps
    end
  end
end
