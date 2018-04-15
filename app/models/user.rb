class User < ApplicationRecord
  has_many :tweets, autosave: true, :dependent => :destroy
  has_many :follows, autosave: true, :dependent => :destroy
  has_many :followers, autosave: true, :class_name => "Follow", :foreign_key => "target_user_id", :dependent => :destroy

  def is_follow?(user_id)
  	self.follows.find_by(target_user_id: user_id).present?
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
