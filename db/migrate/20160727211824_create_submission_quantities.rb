class CreateSubmissionQuantities < ActiveRecord::Migration
  def change
    create_table :submission_quantities do |t|
      t.integer :beginning_value
      t.integer :end_value
      t.references :event, index: true

      t.timestamps
    end
  end
end
