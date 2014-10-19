#encoding: utf-8
class TasksController < ApplicationController
  before_filter :authorize_user!,:except => [:create_question,:question,:answer]
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
    @tasks = Task.where(:role_id=>@role_id,:username=>params[:username])
  end

  def process_list
    @ids = CustomerInfoTask.pluck(:id)
    render :json => {"ids"=>@ids}
  end

  def eventlogs
    @events = EventLog.where(:task_id=>params[:task_id]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
  end

  def create_question
    task = Task.new
    task.username = params[:username]
    @role = check_role_exist(params[:role_code])
    task.role_id = @role.id
    task.task_type = params[:type]
    task.save
    task.created
    if !params[:content].blank?
      @attach =  BpmAttachment.where(:process_id=>params[:task_id],:index=>task.index)
      if @attach.blank?
        attachment = BpmAttachment.new
        attachment.process_id = task.id
        attachment.process_type = task.task_type
        attachment.index = task.index
        attachment.attachment_type = "text"
        attachment.content = params[:content]
        attachment.save
      end
    end
    render :json => {"task_id"=>task.id}
  end

  def question
    @task = Task.find(params[:task_id])
    @role = check_role_exist(params[:role_code])
    @task.role_id = @role.id
    @task.username = params[:username]
    @task.question
    if !params[:content].blank?
      @attach =  BpmAttachment.where(:process_id=>params[:task_id],:index=>@task.index)
      if @attach.blank?
        attachment = BpmAttachment.new
        attachment.process_id = @task.id
        attachment.process_type = @task.task_type
        attachment.index = @task.index
        attachment.attachment_type = "text"
        attachment.content = params[:content]
        attachment.save
      end
    end
    render :json => {"result"=>"t"}
  end


  def answer
    @task = Task.find(params[:task_id])
    @role = check_role_exist(params[:role_code])
    @task.role_id = @role.id
    @task.username = params[:username]
    @task.answer

    if !params[:content].blank?
      @attach =  BpmAttachment.where(:process_id=>params[:task_id],:index=>@task.index)
      if @attach.blank?
        attachment = BpmAttachment.new
        attachment.process_id = @task.id
        attachment.index = @task.index
        attachment.process_type = @task.task_type
        attachment.attachment_type = "text"
        attachment.content = params[:content]
        attachment.save
      end
    end
    render :json => {"result"=>"t"}
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
