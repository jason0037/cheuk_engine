require "pp"
#encoding: utf-8
class GuestsController < ApplicationController
  before_filter :authorize_user!,:except => [:get_all_guests,:set_trail,:get_trail,:reg_guest,:get_guests,:login]
  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  def set_trail
    @trail = GuestTrail.new
    @trail.username = params[:username]
    @trail.ip = params[:ip]
    @trail.page_path = params[:page_path]
    @trail.time_at = params[:time_at]
    result = @trail.save
    render :json => {"result"=>result}
  end

  def get_trail
    @trails = GuestTrail.where(:username=>params[:username])
    render :json => {"guests"=>@guests}
  end

  def get_all_guests
    @guests = OpenfireGuest.paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
    render :json => {"guests"=>@guests}
  end

  def get_guests
    status = params[:status]
    @guests = OpenfireGuest.where(:status=>status)
    render :json => {"guests"=>@guests}
  end

  def reg_guest
    @guests = OpenfireGuest.where(:ip=>params[:ip])
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
