class TopicPolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    true
  end
end