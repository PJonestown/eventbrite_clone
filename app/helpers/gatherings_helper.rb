module GatheringsHelper
  def gathering_creator?
    return false unless signed_in?
    return true if @gathering.creator_id == current_user.id
  end
end
