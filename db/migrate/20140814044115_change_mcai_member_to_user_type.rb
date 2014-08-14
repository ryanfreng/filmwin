class ChangeMcaiMemberToUserType < ActiveRecord::Migration
  def change
    remove_column :users, :mcai_member
    add_column    :users, :user_type, :integer
  end
end
