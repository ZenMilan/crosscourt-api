class CreateProject < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.integer :organization_id, null: false
      t.string :purpose

      t.timestamps
    end

  end
end
