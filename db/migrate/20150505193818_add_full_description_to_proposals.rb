class AddFullDescriptionToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :large_description, :text, null: false, default: ''
  end
end
