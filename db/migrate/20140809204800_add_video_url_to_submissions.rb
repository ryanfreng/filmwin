class AddVideoUrlToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :video_url, :string
  end
end
