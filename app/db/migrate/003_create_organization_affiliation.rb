class CreateOrganizationAffiliation < ActiveRecord::Migration
  def change
    create_table :organization_affiliations do |t|
      t.references :user
      t.references :organization
    end
  end
end
