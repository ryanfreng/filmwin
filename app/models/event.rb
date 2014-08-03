class Event < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 50 }, 
            uniqueness: { case_sensitive: false }
  validates :description,  presence: true, length: { maximum: 200 }
  validates :entry_start_date,  presence: true
  validates :entry_end_date,  presence: true
  validates :judging_date,  presence: true
  validates :show_date,  presence: true
  validates :created_by, presence: true

end
