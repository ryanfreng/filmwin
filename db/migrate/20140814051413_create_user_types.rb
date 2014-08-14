class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table :user_types do |t|
      t.string :name
      t.integer :earlybird_cost
      t.integer :standard_cost

      t.timestamps
    end
  end
end
