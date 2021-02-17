class AddFriendIdFieldToFriendships < ActiveRecord::Migration[6.1]
  def change
    add_reference :friendships, :friend, references: :users,
                   foreign_key: {to_table: :users}

  end
end
