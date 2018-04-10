class Follow < ApplicationRecord
	belongs_to :user, :class_name => "User", :dependent => :destroy
	belongs_to :target_user, :class_name => "User", :dependent => :destroy
end
