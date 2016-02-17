class LandingPagePolicy < Struct.new(:user, :landing_page)
  def index?
    true
  end
end
