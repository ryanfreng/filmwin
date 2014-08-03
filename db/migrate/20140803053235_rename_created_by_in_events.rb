class RenameCreatedByInEvents < ActiveRecord::Migration
  def change
    rename_column :events, :created_by, :user_id
  end
end
