class AddEntrantNameToSubmission < ActiveRecord::Migration
  def change
    add_column  :submissions, :entrant_name, :string
  end
end
