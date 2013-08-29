class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all
    if user.admin?
      can :manage, :all
    elsif user.role? [:user, :editor]
      can :add_photo, Place
      can :create, Obelisk
      can :manage, Obelisk, :user_id => user.id
      can :manage, PlacePhoto, :user_id => user.id
      can :manage, Soldier, :user_id => user.id
      can :manage, Profile, :user_id => user.id
      
      can :edit, PlacePhoto if user.role? [:editor]
      can :edit, Soldier if user.role? [:editor]
      can :edit, Obelisk if user.role? [:editor]

        #s.user_id == user.id if s
        #if s.place_id
        #  return Place.find(s.place_id) == user.id
        #end
        # if s.place)# or s.soldirable.user.id == user.id
      #end
    else

      cannot :all, :rails_admin
    end
    
    

    #if user.role? :user
    #  
    #end
    

    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
