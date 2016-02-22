class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  skip_before_action :force_user_to_create_company, only: [:index]
  layout "landing_page"

  def index
    authorize :landing_page, :index?
  end
end
