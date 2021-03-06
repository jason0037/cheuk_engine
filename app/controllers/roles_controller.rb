#encoding: utf-8
class RolesController < ApplicationController
  before_filter :authorize_user!,:except => [:get_customer_service,:set_session_log,:del_session_log,:set_max_service,:get_max_service,:company,:user_list,:get_role]
  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  def company
    @roles = Role.where(:role_type=>0)
  end

  def get_max_service
    @role = Role.find_by_role_code("customer_service")
    @users = RolesUser.where(:role_id=>@role.id,:username=>params[:username])
    if @users.blank?
        render :json => {"errors"=>"username is not exist"}
        return
    else
        @max_service = @users.first.max_service
    end
    render :json => {"max_service"=>@max_service}
  end

  def set_max_service
    @role = Role.find_by_role_code("customer_service")
    @users = RolesUser.where(:role_id=>@role.id,:username=>params[:username])
    if @users.blank?
        render :json => {"errors"=>"username is not exist"}
        return
    else
        @users.first.max_service = params[:max_service]
        @users.first.save
    end
    render :json => {"result"=>"t"}
  end

  def set_session_log
    @role = Role.find_by_role_code("customer_service")
    @users = RolesUser.where(:role_id=>@role.id,:username=>params[:username])
    if @users.blank?
        render :json => {"errors"=>"username is not exist"}
        return
    else
        @users.first.service = @users.first.service + 1
        @users.first.save
        @session_log = SessionLog.new
        @session_log.username = params[:username]
        @session_log.save
    end
    render :json => {"session_id"=>@session_log.id}
  end

  def del_session_log
    @role = Role.find_by_role_code("customer_service")
    @users = RolesUser.where(:role_id=>@role.id,:username=>params[:username])
    if @users.blank?
        render :json => {"errors"=>"username is not exist"}
        return
    else
        @users.first.service = @users.first.service - 1
        @users.first.save
        @session_log = SessionLog.find(params[:id])
        @session_log.delete
    end
    render :json => {"result"=>"t"}
  end


  def get_customer_service
    @role = Role.find_by_role_code("customer_service")
    @users = RolesUser.where(:role_id=>@role.id).limit(1).order("service")
    render :json => {"username"=>@users.first.username}
  end

  def assign
    @role_list = Role.all.collect { |type| [type.name, type.id] } 
  end

  def process_set
    if params[:role][:process_type] == "1"
      task = CustomerInfoTask.find(params[:role][:process_id])
      task.role_id = params[:role][:roles_id]
      task.username = params[:role][:username]
      task.save
    end
    redirect_to assign_roles_path
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    @role = Role.find(params[:id])
  end

  def add_member
    @role = Role.find(params[:id])
    @role_user = RolesUser.new
  end

  def del_member
    @role = Role.find(params[:id])
    @role_user = RolesUser.find(params[:user_id])
    @role_user.delete
    redirect_to "/roles/#{@role.id}/mlist"
  end

  def mlist
    @rusers = RolesUser.where(:role_id=>params[:id])
  end

  def get_role
    @role = Role.where(:role_code=>params[:role_code]).first
    render :json => {"role"=>@role}
  end

  def user_list
    role = Role.where(:role_code=>params[:role_code]).first
    @role_users = RolesUser.where(:role_id=>role.id).pluck(:username) 
    render :json => {"usernames"=>@role_users}
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id]) 
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    @role = Role.find(params[:id])
    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
