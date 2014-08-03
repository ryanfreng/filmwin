class Event < ActiveRecord::Base
  belongs_to :user
  validates :name,  presence: true, length: { maximum: 50 }, 
            uniqueness: { case_sensitive: false }
  validates :description,  presence: true, length: { maximum: 1000 }
  validates :sub_heading, presence: true, length: { maximum: 250 }
  validates :entry_start_date,  presence: true
  validates :entry_end_date,  presence: true
  validates :judging_date,  presence: true
  validates :show_date,  presence: true
  validates :user_id, presence: true

end