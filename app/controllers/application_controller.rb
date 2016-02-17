class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :force_create_company, unless: :devise_controller?

  include Pundit
  after_action :verify_authorized, unless: :devise_controller?

  # def current_company
  #   current_user.company
  # end

  # helper_method :current_company

  private
   def force_create_company
     return redirect_to new_company_path unless current_user.company.present?
  end
end
