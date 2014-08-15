class Order < ActiveRecord::Base
  has_many :submissions
  
end
