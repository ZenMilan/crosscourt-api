class CreateAffiliation < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.integer :user_id
      t.integer :organization_id
      t.integer :project_id

      t.timestamps
    end

  end
end
