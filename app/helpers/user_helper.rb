module UserHelper
  def new_friendship(user)
    pending = current_user.pending_friendships.where(friend_id: user.id).first
    confirmed = current_user.confirmed_friendships.where(friend_id: user.id).first
    unless user.id == current_user.id
      link = if confirmed

               link_to 'Remove',
                       "/friendships/#{confirmed.id}",
                       method: 'delete',
                       class: 'p-1 rounded btn-dark small no-link'
             elsif pending

               link_to 'Cancel',
                       "/friendships/#{pending.id}",
                       method: 'delete',
                       class: 'p-1 rounded btn-dark small no-link'
             else
               capture do
                 link_to 'Add friend',
                         friendships_path(
                           friendship: {
                             user_id: current_user,
                             friend_id: user,
                             confirmed: false
                           }
                         ),
                         method: 'post',
                         class: 'p-1 rounded btn-dark small no-link'
               end
             end
    end
    link
  end
end
