class CreateInvitation < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :type
      t.integer :sender_id
      t.string :recipient_email
      t.integer :organization_id
      t.integer :project_id
      t.string :token
      t.datetime :sent_at

      t.timestamps
    end

    add_index :invitations, :token, unique: true
  end
end
