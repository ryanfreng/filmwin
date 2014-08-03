class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :entry_start_date
      t.datetime :entry_end_date
      t.datetime :show_date
      t.datetime :judging_date

      t.timestamps
    end
  end
end
