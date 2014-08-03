class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :event_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
