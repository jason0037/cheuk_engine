require "pp"
#encoding: utf-8
class GuestsController < ApplicationController
  before_filter :authorize_user!,:except => [:reg_guest,:get_guests,:login]
  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  def get_guests
    status = params[:status]
    @guests = OpenfireGuest.where(:status=>status)
    render :json => {"guests"=>@guests}
  end

  def reg_guest
    username = params[:username]
    @guests = OpenfireGuest.where(:username=>username)
    if @guests.blank?
      @guest = OpenfireGuest.new
    else
      @guest = @guests.first
    end
    if !params[:status].blank?
      @guest.status = params[:status]
    end
    if !params[:ip].blank?
      @guest.ip = params[:ip]
    end
    if !params[:customer_service].blank?
      @guest.customer_service = params[:customer_service]
    end
    if !params[:last_visit].blank?
      @guest.last_visit = params[:last_visit]
    end
    if !params[:username].blank?
      @guest.username = params[:username]
    end
    @guest.save
    render :json => {"result"=>"ok"}
  end
  
end
