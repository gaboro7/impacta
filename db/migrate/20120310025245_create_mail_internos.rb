class CreateMailInternos < ActiveRecord::Migration
  def change
    create_table :mail_internos do |t|
      t.string :mail
      t.integer :conmail_id, :null => false
      t.string :conmail_type, :null => false

      t.timestamps
    end
  end
end
