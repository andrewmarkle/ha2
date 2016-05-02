class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  skip_after_action :verify_policy_scoped, only: :index

  layout 'landing_page'

  def index
    authorize :landing_page, :index?
  end
end
