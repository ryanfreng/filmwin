class SubmissionQuantity < ActiveRecord::Base
  belongs_to :event

  validates :beginning_value, presence: true, numericality: { only_integer: true }
  validates :end_value, presence: true, numericality: { only_integer: true }
  validates :event_id, presence: true
  validate :non_overlapping

  def siblings
    if !self.new_record? and !event.nil?
      s = event.submission_quantities.where('id <> ?', id)
    elsif self.event_id
      s = Event.find(event_id).submission_quantities
    end
  end

  private

    def non_overlapping
      if siblings and !siblings.empty?
        siblings.each do |s|
          if (s.beginning_value <= beginning_value) and (s.end_value >= beginning_value)
            errors.add(:beginning_value, 'may not overlap another another submission_quantity')
          elsif s.end_value >= end_value and s.beginning_value <= end_value
            errors.add(:end_value, 'may not overlap another submission_quantity')
          elsif s.beginning_value >= beginning_value and s.end_value <= end_value
            errors.add(:beginning_value, 'may not be contained within another quantity')
            errors.add(:end_value, 'may not be contained within another quantity')
          end
        end
      end
    end
end
