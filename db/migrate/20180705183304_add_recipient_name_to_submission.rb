class AddRecipientNameToSubmission < ActiveRecord::Migration
  def change
    add_column  :submissions, :recipient_name, :string
  end
end
