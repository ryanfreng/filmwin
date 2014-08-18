class AddOrderIdToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :order_id, :integer
  end
end
