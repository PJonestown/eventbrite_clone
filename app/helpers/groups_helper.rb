module GroupsHelper
  def new_gathering_permission?
    return false unless signed_in?
    if @group.restricted?
      true if privileged_member?
    else
      true if @group.members.include?(current_user)
    end
  end

  def new_memberships_permission?
    true if privileged_member?
  end

  def privileged_member?
    @group ||= @gathering.group
    return false unless signed_in?
    return true if @group.owner_id == current_user.id ||
                   @group.moderators.include?(current_user)
  end
end
