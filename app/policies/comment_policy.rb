class CommentPolicy < ApplicationPolicy
  attr_reader :current_user, :comment

  def initialize(current_user, comment)
    @current_user = current_user
    @comment = comment
  end

  def update?
    @current_user&.admin? || @comment.user_id == @current_user.id
  end

  def destroy?
    @current_user&.admin? || @comment.user_id == @current_user.id
  end
end
