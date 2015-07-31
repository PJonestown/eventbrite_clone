module GroupsHelper
  def new_gathering_permission?
    return false unless signed_in?
    if @group.restriction_type == 0
      true if @group.members.include?(current_user)

    elsif @group.restriction_type == 1
      true if @group.owner_id == current_user.id ||
              @group.moderators.include?(current_user)

    else
      true if current_user.id == @group.owner_id
    end
  end
end
