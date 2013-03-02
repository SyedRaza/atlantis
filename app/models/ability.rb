# To change this template, choose Tools | Templates
# and open the template in the editor.

class Ability
  include CanCan::Ability

  def initialize (user)
    user ||= User.new # Guest user
    #
    # User is Admin
    if user.role? :admin
      can :manage, :all

      # User is Normal User
    elsif user.role? :user
      can :read, [Dashboard,Company,Contact,Lead,Opportunity,Vteam,Note]
      can :create, [Company,Contact,Lead,Opportunity,Vteam,Note]
      can [:update,:delete], Company do |o| o.try(:user) == user end
      can [:update,:delete], Contact do |o| o.try(:user) == user end
      can [:update,:delete], Lead do |o| o.try(:user) == user end
      can [:update,:delete], Vteam do |o| o.try(:user) == user end
      can [:update,:delete], Note do |o| o.try(:user) == user end
      can [:update,:delete], Opportunity do |o| o.try(:user) == user end
      can :manage, User do |o| o == user end
      can :manage, Dashboard do |o| o.try(:user) == user end
      can :details, [Lead, Opportunity, Vteam]
    else
      #can :manage, Devise::Session
    end
  end
end

#    user.roles.each do |role|
#      role.permissions.each do |p|
#        can :read, p.resource.class_name.to_s.classify.constantize do |subject|
#          p.resource.class_name == subject.id and p.can_read
#        end
#        can :create, p.resource.class_name.to_s.classify.constantize do |subject|
#          p.resource.class_name == subject.id and p.can_create
#        end
#        can :update, p.resource.class_name.to_s.classify.constantize do |subject|
#          p.resource.class_name == subject.id and p.can_update
#        end
#        can :destroy, p.resource.class_name.to_s.classify.constantize do |subject|
#          p.resource.class_name == subject.id and p.can_delete
#        end
#      end
#    end