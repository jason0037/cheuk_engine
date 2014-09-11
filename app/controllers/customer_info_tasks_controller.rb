#encoding: utf-8
class CustomerInfoTasksController < ApplicationController

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  def pass
    task = CustomerInfoTask.find(params[:task_id])
    task.pass
    result = task.save
    render :json => {"result"=>result}
  end

  def fail
    task = CustomerInfoTask.find(params[:task_id])
    task.back
    result = task.save
    render :json => {"result"=>result}
  end

  def apply
    task = CustomerInfoTask.find(params[:task_id])
    task.apply
    result = task.save
    render :json => {"result"=>result}
  end

  def create_instance
    task = CustomerInfoTask.new
    task.username = params[:username]
    @role_user = RolesUser.find_by_username params[:username]
    if !@role_user.blank?
      task.role_id = @role_user.role_id
    end
    task.save
    render :json => {"task_id"=>task.id}
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

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
    respond_to do |format|
      if @role.update(role_params)
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
