class PhotoPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end
end
