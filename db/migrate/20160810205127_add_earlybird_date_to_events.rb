class AddEarlybirdDateToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :earlybird_date, :datetime
  end
end
