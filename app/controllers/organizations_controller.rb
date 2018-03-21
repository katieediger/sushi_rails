class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organization = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
    unless current_organization.id == @organization.id
      flash[:danger] = "That's not your organization"
      redirect_to root_path
      return
    end
  end

  def join
    @organization = Organization.find(params[:id])
  end

  def confirm
    @organization = Organization.find(params[:id])
    if current_user.organization_id != nil
      redirect_to('/user')
      flash[:danger] = "Error: You are already a member of an organization"
    elsif
      organization_params[:password] != @organization.password_digest
      redirect_to('/user')
      flash[:danger] = "Wrong password"
    else
      current_user.update(organization_id: @organization.id)
      redirect_to('/user')
      flash[:danger] = "Okay!"
    end
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      user = current_user
      user.update(organization_id: @organization.id)
      redirect_to('/organizations')
    else
      flash[:danger] = "Error: #{@organization.errors.full_message(@organization.name, 'already exists')}"
      redirect_to ('/organizations/new')
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to ("/user"), notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :email, :password_digest, :password)
    end
end
