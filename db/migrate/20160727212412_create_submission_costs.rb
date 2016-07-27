class CreateSubmissionCosts < ActiveRecord::Migration
  def change
    create_table :submission_costs do |t|
      t.integer :standard
      t.integer :earlybird
      t.references :submission_quantity, index: true
      t.references :user_type, index: true

      t.timestamps
    end
  end
end
