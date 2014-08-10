class CreateProject < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :purpose
      t.references :organization

      t.timestamps
    end
  end
end
