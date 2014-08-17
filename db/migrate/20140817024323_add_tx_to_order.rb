class AddTxToOrder < ActiveRecord::Migration
  def change
    add_column :events, :txn_id, :string
  end
end
