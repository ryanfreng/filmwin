class RemoveAuthStatusFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :auth_status
  end
end
