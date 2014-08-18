class ChangeOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :phone
    rename_column :orders, :auth_amount, :payment_gross
  end
end
