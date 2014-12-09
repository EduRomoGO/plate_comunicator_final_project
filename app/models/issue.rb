class Issue < ActiveRecord::Base
	has_many :comments
  belongs_to :user
  belongs_to :target_user, class_name: "User"
end
