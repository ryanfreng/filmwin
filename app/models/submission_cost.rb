class SubmissionCost < ActiveRecord::Base
  belongs_to :submission_quantity
  belongs_to :user_type
end
