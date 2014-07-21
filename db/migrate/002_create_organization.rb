class CreateOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :org_name, null: false

      t.timestamps
    end
  end
end
