class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :category_id
      t.string :user_role
      t.string :client
      t.string :title
      t.string :budget
      t.string :production_company
      t.text :comments_other

      t.timestamps
    end
  end
end
