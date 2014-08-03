class AddSubHeadingToEvents < ActiveRecord::Migration
  def change
    add_column :events, :sub_heading, :string
  end
end
