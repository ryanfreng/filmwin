class Category < ActiveRecord::Base
  belongs_to  :event
  has_many :children, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category"

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :event_id, presence: true
end
