#encoding: utf-8
class TasksController < ApplicationController
  # GET /roles
  # GET /roles.json
  def index
    @tasks = CustomerInfoTask.paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  def process_set
    
  end

  def get_tasks
    @role_id = Role.find_by_role_code(params[:role_code]).id
    @tasks = CustomerInfoTask.where(:role_id=>@role_id,:username=>params[:username])
    render :json => {"task_list"=>@tasks}
  end

  def process_list
    @ids = CustomerInfoTask.pluck(:id)
    render :json => {"ids"=>@ids}
  end

  def eventlogs
    @events = EventLog.where(:task_id=>params[:task_id]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
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
    last_index = task.index - 1
    event = EventLog.where(:task_id=>task.id,:index=>last_index)
    task.role_id = event.first.role_id
    task.username = event.first.username
    result = task.save
    render :json => {"result"=>result}
  end

  def apply
    task = CustomerInfoTask.find(params[:task_id])
    task.apply
    @role = check_role_exist("customer_managers_key")
    task.assign
    task.role_id = @role.id
    task.username = @role.roles_users.first.username
    result = task.save
    render :json => {"result"=>result}
  end

  def create_instance
    task = Task.new
    task.username = params[:username]
    @role = check_role_exist(params[:role_key])
    task.role_id = @role.id
    task.save
    attachment = BpmAttachment.new
    attachment.process_id = task.id
    attachment.index = task.index
    attachment.attachment_type = "text"
    attachment.content = params[:content]
    attachment.save
    render :json => {"task_id"=>task.id}
  end

  def check_role_exist(key)
    @role = Role.find_by_role_code(key)
    if @role.blank?
      render :json => {:result=>false,:desc=>"流程角色还没有创建."}
      return
    end
    return @role
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
