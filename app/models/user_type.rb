class UserType < ActiveRecord::Base
  has_many :users

  validates :name, presence: true, length: { maximum: 20 }
  validates :earlybird_cost, presence: true, numericality: { only_integer: true }
  validates :standard_cost, presence: true, numericality: { only_integer: true }
end
