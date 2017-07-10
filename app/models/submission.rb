class Submission < ActiveRecord::Base
  #default_scope order('id ASC')
  
  belongs_to :user
  belongs_to :category
  belongs_to :event
  belongs_to :order

  validates :title, presence: true
  validates :user, presence: true
  validates :category, presence: true
  validates :event, presence: true
  validates :comments_other, presence: true
  #VALID_VIDEO_URL_REGEX = /http:\/\/(?:www.)?(vimeo|youtube).com\/(?:watch\?v=)?(.*?)(?:\z|&)/
  VALID_VIDEO_URL_REGEX = /(http(s)?\:\/\/)?((www\.)?(youtube|vimeo)\.com|youtu\.?be)\/\w+/
  validates :video_url, presence: true, format: { with: VALID_VIDEO_URL_REGEX }, allow_blank: true

end
