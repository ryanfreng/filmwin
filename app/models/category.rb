class Category < ActiveRecord::Base
  belongs_to  :event
  has_many  :submissions, dependent: :destroy
  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Category"

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :event_id, presence: true
end
