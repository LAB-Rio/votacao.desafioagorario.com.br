class AddValidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :checked, :boolean, default: true, null: false
  end
end
