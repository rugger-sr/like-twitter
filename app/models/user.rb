class User < ApplicationRecord
  has_many :tweets
  has_many :follows
  has_many :followers, :class_name => "Follow", :foreign_key => "target_user_id"
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

end
