class Movie < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 25 }
  validates :description, presence: true, length: { maximum: 500 }
  has_many :votes, dependent: :destroy

  def like
  	self.likes ||= 0
    self.likes += 1
  end

  def unlike
  	self.likes ||= 0
    self.likes -= 1
  end

  def hate
  	self.hates ||= 0
    self.hates += 1
  end

  def unhate
  	self.hates ||= 0
  	self.hates -= 1
  end

end
