class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :type, limit: 50, null: false
      t.string :fname, null: false
      t.string :lname, null: false
      t.string :email, null: false
      t.string :gh_access_token, default: nil
      t.string :password_digest
      t.integer :invitation_id

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
