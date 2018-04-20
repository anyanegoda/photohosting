class PhotosCommentPolicy < ApplicationPolicy
  attr_reader :current_user, :photos_comment

  def initialize(current_user, photos_comment)
    @current_user = current_user
    @photos_comment = photos_comment
  end

  def update?
    @current_user&.admin? || @photos_comment.user_id == @current_user.id
  end

  def destroy?
    @current_user&.admin? || @photos_comment.user_id == @current_user.id
  end
end
