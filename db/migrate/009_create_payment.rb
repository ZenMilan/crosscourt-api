class CreatePayment < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :organization_id
      t.integer :user_id
      t.string :payment_details

      t.timestamps
    end

    add_index :payments, :organization_id, unique: true
  end
end
