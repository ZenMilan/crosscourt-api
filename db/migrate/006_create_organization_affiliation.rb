class CreateOrganizationAffiliation < ActiveRecord::Migration
  def change
    create_table :organization_affiliations do |t|
      t.integer :user_id
      t.integer :organization_id

      t.timestamps
    end

  end
end
