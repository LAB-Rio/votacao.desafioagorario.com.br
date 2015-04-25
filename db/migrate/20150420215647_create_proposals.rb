class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.string :image_url, null: false, default: ''

      t.references :category, index: true

      t.timestamps null: false
    end

    add_foreign_key :proposals, :categories
  end
end
