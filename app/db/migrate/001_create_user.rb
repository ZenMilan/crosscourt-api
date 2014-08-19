class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type, limit: 50, null: false
      t.string :uid, limit: 50, null: false
      t.string :token, limit: 100
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :uid, unique: true
  end
end
