class AddUploadUrlToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :upload_url, :string, default: nil
  end
end
