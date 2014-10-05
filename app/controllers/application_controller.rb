class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize_user!

  def authorize_user!
	if cookies[:cheuk_key].blank? || cookies[:cheuk_key] !="idfidfsdfdsf8833"
		redirect_to new_user_path
	end
 end
end
