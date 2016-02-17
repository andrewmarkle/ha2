class CompanyController < ApplicationController
  skip_before_action :force_create_company, only: [:new, :create]
  layout Proc.new { |controller| controller.current_user.company.present? ? "application" : "no_nav" }

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    @company.owner = current_user
    if @company.save
      @company.users << @company.owner
      redirect_to dashboard_url
    else
      render :new
    end
    authorize @company
  end

  def edit
    set_company
  end

  def update
    set_company
    if @company.update(company_params)
      redirect_to edit_company_path(@company), success:
      'Company successfully updated!'
    else
      render :edit
    end
  end

  private

  def set_company
    @company = current_user.company
    authorize @company
  end

  def company_params
    params.require(:company).permit(:name, :url, :owner_id, :time_zone)
  end
end
