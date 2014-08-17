class Order < ActiveRecord::Base
  has_many :submissions

  #before_destroy { |record| record.submissions.each do { |s| s.update_attributes(order_id: nil) } }
  
end
