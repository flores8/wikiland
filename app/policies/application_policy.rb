class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && (record.user == user || user.role?(:admin, :collaborator))
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (record.user == user || user.role?(:admin))
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end

