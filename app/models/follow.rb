class Follow < ApplicationRecord
  belongs_to :user, :class_name => "User"
  belongs_to :target_user, :class_name => "User"
end
