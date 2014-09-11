#encoding: utf-8
class RolesUsersController < ApplicationController
  
  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
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
    @rusers = RolesUser.new
    @rusers.role_id = params[:roles_user][:role_id]
    @rusers.username = params[:roles_user][:username]
    respond_to do |format|
      if @rusers.save
        format.html { redirect_to roles_path, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @rusers }
      else
        format.html { render :new }
        format.json { render json: @rusers.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @rolesusers.update(role_params)
        format.html { redirect_to @rolesusers, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @rolesusers }
      else
        format.html { render :edit }
        format.json { render json: @rolesusers.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @rolesuser = RolesUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name)
    end
end
