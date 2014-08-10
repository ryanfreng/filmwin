class AddFieldsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :director, :string, default: nil
    add_column :submissions, :editor, :string, default: nil
    add_column :submissions, :producer, :string, default: nil
    add_column :submissions, :cinematographer, :string, default: nil
  end
end
