class CollectionPolicy < ApplicationPolicy
  attr_reader :current_user, :collection

  def initialize(current_user, collection)
    @current_user = current_user
    @collection = collection
  end

  def update?
    @current_user&.admin? || @current_user.id == @collection.user_id
  end

  def destroy?
    @current_user&.admin? || @current_user.id == @collection.user_id
  end

end
