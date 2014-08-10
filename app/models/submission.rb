class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :event

  validates :title, presence: true
  validates :user, presence: true
  validates :category, presence: true
  validates :event, presence: true
  #VALID_VIDEO_URL_REGEX = /http:\/\/(?:www.)?(vimeo|youtube).com\/(?:watch\?v=)?(.*?)(?:\z|&)/
  VALID_VIDEO_URL_REGEX = /(http(s)?\:\/\/)?((www\.)?(youtube|vimeo)\.com|youtu\.?be)\/.+/
  validates :video_url, presence: true, format: { with: VALID_VIDEO_URL_REGEX }

end