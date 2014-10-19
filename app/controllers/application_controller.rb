#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize_user!

  def authorize_user!
	if cookies[:cheuk_key].blank? || cookies[:cheuk_key] !="idfidfsdfdsf8833"
		redirect_to new_user_path
	end
 end

  def check_role_exist(key)
    @role = Role.find_by_role_code(key)
    if @role.blank?
      render :json => {:result=>false,:desc=>"流程角色还没有创建."}
      return
    end
    return @role
  end
end
