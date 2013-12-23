class CreateAccessToken < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :token, null: false
      t.boolean :available, default: true

      t.timestamps
    end

    add_index :access_tokens, :token, unique: true
  end
end
