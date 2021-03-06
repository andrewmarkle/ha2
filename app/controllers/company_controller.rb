class CompanyController < ApplicationController
  layout proc { |controller| controller.current_user.company ? 'application' : 'no_nav' }
  skip_after_action :verify_policy_scoped, only: [:new, :create]

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      @company.users << current_user
      redirect_to dashboard_url
    else
      render :new
    end
    authorize @company
  end

  # def edit
  #   set_company
  # end

  # def update
  #   set_company
  #   if @company.update(company_params)
  #     redirect_to edit_company_path(@company), success:
  #     'Company successfully updated!'
  #   else
  #     render :edit
  #   end
  # end

  # private

  # def set_company
  #   @company = current_user.company
  #   authorize @company
  # end

  def company_params
    params.require(:company).permit(:name, :url)
  end
end
