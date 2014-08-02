class AddCompanyAndTitleAndMembershipToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mcai_member, :boolean, default: false
    add_column :users, :title, :string
    add_column :users, :company, :string
  end
end
