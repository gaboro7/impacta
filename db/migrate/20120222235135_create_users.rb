class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nombre, :null => false
      t.string :email, :null => false
      t.string :encrypted_password, :null => false
      t.string :salt
      t.boolean :admin, :default => false

      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :nombre, :unique => true

    User.create :nombre => "admin", :email => "admin@admin.com", :admin => true, :password => "adminadmin", :password_confirmation => "adminadmin"

  end
end
