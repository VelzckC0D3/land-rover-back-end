class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all

    can :manage, :all if user.role == 'admin'

    return unless user.role == 'user'

    can :manage, Reservation, user_id: user.id
  end
end
