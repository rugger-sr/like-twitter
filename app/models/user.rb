class User < ApplicationRecord
  has_many :tweets, autosave: true, :dependent => :destroy
  has_many :follows, autosave: true, :dependent => :destroy
  has_many :followers, autosave: true, :class_name => "Follow", :foreign_key => "target_user_id", :dependent => :destroy

	# Home画面の都合上、自分をフォローした状態をデフォルトにする
  after_commit on: :create  do
  	self.reload
  	Follow.create!(user_id: self.id, target_user_id: self.id) if self.follows.count == 0
  end
  def follow_count
  	self.follows.where.not(target_user_id: self.id).count
  end
  def follower_count
  	self.followers.where.not(user_id: self.id).count
  end

  def is_follow?(user_id)
  	self.follows.find_by(target_user_id: user_id).present?
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
