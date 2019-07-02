class AddAnimatorWriterSound < ActiveRecord::Migration
  def change
    add_column  :submissions, :animator, :text
    add_column  :submissions, :writer, :text
    add_column  :submissions, :sound_designer, :text
    add_column  :submissions, :running_time, :text
  end
end
