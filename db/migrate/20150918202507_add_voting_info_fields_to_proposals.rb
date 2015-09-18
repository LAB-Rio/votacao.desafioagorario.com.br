class AddVotingInfoFieldsToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :fullname, :text
    add_column :proposals, :age, :text
    add_column :proposals, :gender, :text
    add_column :proposals, :district, :text
    add_column :proposals, :degree, :text
    add_column :proposals, :group, :text
    add_column :proposals, :facebook, :text
    add_column :proposals, :about, :text
    add_column :proposals, :reason, :text
    add_column :proposals, :video_url, :text
    add_column :proposals, :email, :text
    add_column :proposals, :phone, :text
    add_column :proposals, :zone, :text
  end
end
