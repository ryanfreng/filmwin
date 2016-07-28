class SubmissionQuantity < ActiveRecord::Base
  belongs_to :event

  validates :beginning_value, presence: true, numericality: { only_integer: true }
  validates :end_value, presence: true, numericality: { only_integer: true }
  validates :event_id, presence: true
  validate :non_overlapping

  def siblings
    if event
      s = event.submission_quantities.where('id <> ?', id)
    end
  end

  private

    def non_overlapping
      if siblings and !siblings.empty?
        siblings.each do |s|
          if (s.beginning_value < beginning_value) and (s.end_value > beginning_value)
            errors.add(:beginning_value, 'Beginning_value may not overlap another another submission_quantity.')
            false
          elsif s.end_value > end_value and s.beginning_value < end_value
            errors.add(:end_value, 'End_Value may not overlap another submission_quantity')
            false
          end
        end
      end
    end
end
