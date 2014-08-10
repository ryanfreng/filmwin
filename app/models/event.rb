class Event < ActiveRecord::Base
  belongs_to :user
  has_many  :submissions
  has_many  :categories
  validates :name,  presence: true, length: { maximum: 50 }, 
            uniqueness: { case_sensitive: false }
  validates :description,  presence: true, length: { maximum: 1000 }
  validates :sub_heading, presence: true, length: { maximum: 250 }
  validates :entry_start_date,  presence: true
  validates :entry_end_date,  presence: true
  validates :judging_date,  presence: true
  validates :show_date,  presence: true
  validates :user_id, presence: true

  def parent_categories 
    categories.where(parent_id: nil).to_a
  end

  def child_categories
    categories - parent_categories
  end

end
