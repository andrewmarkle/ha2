class DashboardPolicy < Struct.new(:user, :dashboard)
  def index?
    true unless user.company.nil?
  end
end
