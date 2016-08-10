class SubmissionCost < ActiveRecord::Base
  belongs_to :submission_quantity
  belongs_to :user_type

  validates :standard, presence: true, numericality: { only_integer: true }
  validates :earlybird, presence: true, numericality: { only_integer: true }
  validates :user_type_id, presence: true
  validates :submission_quantity_id, presence: true

  def event
    submission_quantity.event
  end

end
