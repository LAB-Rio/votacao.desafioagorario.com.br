class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.string :type, null: false, default: ''
      t.integer :sequence, null: false, default: 0

      t.timestamps null: false
    end
  end
end
