class CreateProposal < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.boolean :approved, default: false
      t.integer :project_id

      t.timestamps
    end

  end
end
