class User < ActiveRecord::Base
  has_many :events
  has_many :submissions, dependent: :destroy
  belongs_to :user_type
  has_secure_password
  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6, maximum: 120}, on: :create
  validates :password, length: { minimum: 6, maximum: 120 }, on: :update, allow_blank: true

  has_many :events

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def submission_events
    se = []
    self.submissions.each do |s|
      se.push(s.event) unless se.include?(s.event)
    end
    se.sort {|a, b| b.show_date <=> a.show_date }
  end

  def unpaid_submissions
    us = []
    submissions.each do |s|
      us << s if s.order.nil?
    end
  end

  def unpaid_submissions(event)
    us = []
    submissions.where(event_id: event, order_id: nil).each do |s|
      #us << s if s.order.nil?
      us << s
    end
  end

  def current_cost(event)
    se = []
    submissions.each do |s|
      se << s if s.event == event
    end
    sub_count = se.count
    submission_quantity = SubmissionQuantity.where("event_id = #{event.id} and beginning_value <= #{sub_count} and end_value >= #{sub_count}").first
    if submission_quantity && !submission_quantity.nil?
      submission_cost = SubmissionCost.where("submission_quantity_id = #{submission_quantity.id} and user_type_id = #{user_type.id}").first
      if submission_cost
        if Date.today <= event.earlybird_date
          submission_cost.earlybird
        else
          submission_cost.standard
        end
      end
    elsif Date.today < event.earlybird_date
      user_type.earlybird_cost
    else
      user_type.standard_cost
    end
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
