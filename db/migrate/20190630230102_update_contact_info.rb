class UpdateContactInfo < ActiveRecord::Migration
  def change
    add_column  :submissions, :contact_phone, :text
    add_column  :submissions, :contact_email, :text
    rename_column :submissions, :entrant_name, :contact_name
  end
end
