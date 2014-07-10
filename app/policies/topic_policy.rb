class TopicPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.present? && user.role?("admin")
  end

  def update?
    create?
  end

  def destroy?
    user.present? && (user.role?(:admin) || user.role?(:moderator))
  end
  
end