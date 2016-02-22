class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :force_user_to_create_company, unless: :devise_controller?
  include Pundit
  after_action :verify_authorized, unless: :devise_controller?

  private

  def force_user_to_create_company
    unless current_user&.company.present?
     redirect_to new_company_path
    end
  end
end
