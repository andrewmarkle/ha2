class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  layout "landing_page"

  def index
    authorize :landing_page, :index?
  end
end
