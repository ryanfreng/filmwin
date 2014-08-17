class RemoveTxnIdFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :txn_id
  end
end
