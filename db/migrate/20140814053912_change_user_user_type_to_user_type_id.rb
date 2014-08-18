class ChangeUserUserTypeToUserTypeId < ActiveRecord::Migration
  def change
    rename_column :users, :user_type, :user_type_id
  end
end
