class CreatePayment < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :organization
      t.string :details

      t.timestamps
    end
  end
end
