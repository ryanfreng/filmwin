class RemoveAuthIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :auth_id
  end
end
