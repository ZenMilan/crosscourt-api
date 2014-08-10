class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type, limit: 50, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :gh_access_token, limit: 100

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
