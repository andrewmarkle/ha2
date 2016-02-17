class CompanyPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true if user
  end

  def update?
    true if user
  end
end
