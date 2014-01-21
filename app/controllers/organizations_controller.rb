class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]


  def index
    @user_organizations = current_user.organizations
  end

  def show
    @organization = Organization.find(params[:id])
    @finance_approver = @organization.finance_approver
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      current_user.organizations << @organization
      flash[:notice] = "#{@organization.name.titleize} has successfully been added to user #{current_user.email}!"
      redirect_to dashboard_path(@user)
    else
      flash[:notice] = "Error(s) while creating organization:
      #{@organization.errors.full_messages.to_sentence}"
      redirect_to new_user_organization_path(current_user)
    end
  end

  def update
    if @organization.update(organization_params)
      flash[:notice] = "#{@organization.name.titleize} has successfully been updated!"
      redirect_to user_organizations_path(current_user)
    else
      flash[:notice] = "Error(s) while editing organization:
      #{@organization.errors.full_messages.to_sentence}"
      redirect_to edit_organization_path(@organization)
    end
  end
  
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  def add_financeapprover
    user = User.find_by_id(params[:organization][:finance_approver])
    @organization = Organization.find(params[:organization_id])

    if @organization.update_attributes(finance_approver: user)
      flash[:notice] = 
      "#{@organization.finance_approver.first_name.capitalize!} 
                                              is a Finance Approver!"
      redirect_to user_organizations_path(current_user)
    else
      flash[:notice] = "Error(s) while creating income:
      #{@organization.errors.full_messages.to_sentence}"
      redirect_to new_organization_finance_approver_path(@organization)
    end
  end

  def financeapprover
    @organization = Organization.find(params[:organization_id])
    @finance_approvers = FinanceApproverRole.users
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :website)
    end
end

