class Role < ActiveRecord::Base
	attr_accessible :name,:role_code
	has_many :roles_users, :foreign_key=>"role_id"
end
