class CreateFeature < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :project_id, null: false
      t.string  :title
      t.text    :description
      t.decimal :price, precision: 8, scale: 2
      t.string  :delivery_time

      t.timestamps
    end

  end
end
