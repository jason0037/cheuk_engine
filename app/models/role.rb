#encoding: utf-8
class Role < ActiveRecord::Base
	attr_accessible :name,:role_code, :role_type
	has_many :roles_users, :foreign_key=>"role_id"
	accepts_nested_attributes_for :roles_users

 	def as_json_options
	    @options={}
	    @options[:except] ||= [:created_at, :updated_at]
	end

	def role_type_name
		value1 = ""
		if self.role_type == 0
			value1 = "标准"
		else
			value1 = "流程"
		end
		value1
	end
end
