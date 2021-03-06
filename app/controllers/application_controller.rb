class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include Pundit
  after_action :verify_authorized, :verify_policy_scoped, unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_company
    @_current_user_company ||= current_user&.company
  end
  helper_method :current_company

  private

  def user_not_authorized
    if current_company.nil?
      flash[:alert] = 'You need to finish setting up your company.'
      redirect_to(new_company_path)
    else
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referrer || root_path)
    end
  end
end
