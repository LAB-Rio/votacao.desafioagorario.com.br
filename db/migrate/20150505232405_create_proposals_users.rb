class CreateProposalsUsers < ActiveRecord::Migration
  def change
    create_table :proposals_users do |t|
      t.references :user, index: true
      t.references :proposal, index: true
      
      t.timestamps null: false
    end

    add_foreign_key :proposals_users, :users
    add_foreign_key :proposals_users, :proposals
  end
end
