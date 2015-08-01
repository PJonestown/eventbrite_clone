module GroupsHelper
  def new_gathering_permission?
    return false unless signed_in?
    if @group.restricted?
      true if @group.owner_id == current_user.id ||
              @group.moderators.include?(current_user)
    else
      true if @group.members.include?(current_user)
    end
  end

  def new_memberships_permission?
    return false unless signed_in?
    true if @group.owner_id == current_user.id ||
            @group.moderators.include?(current_user)
  end
end
