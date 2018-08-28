class AddExtraCrewToSubmission < ActiveRecord::Migration
  def change
    add_column  :submissions, :extra_crew, :text
  end
end
