class PhotoPolicy < ApplicationPolicy
  attr_reader :current_user, :photo

  def initialize(current_user, photo)
    @current_user = current_user
    @photo = photo
  end

  def update?
    @current_user&.admin? || @current_user.id == @photo.user_id
  end

  def destroy?
    @current_user&.admin? || @current_user.id == @photo.user_id
  end

end
