class Bug < ApplicationRecord
  validates :bug_title, presence: true
  validates_uniqueness_of :bug_title
  validates :status, presence: true
  validates :bug_type, presence: true


  attr_accessor :bug_id, :image
  
  belongs_to :user
  belongs_to :project

  mount_uploader :image, ImageUploader

end
