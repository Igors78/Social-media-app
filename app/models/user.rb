class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  has_many :friend_requests_sent, -> { where(status: false) },
           class_name: 'Friendship'
  has_many :requests_sent_to, through: :friend_requests_sent, source: :friend

  has_many :friend_requests_received, -> { where(status: false) },
           class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :requests_received_from, through: :friend_requests_received,
                                    source: :user

  has_many :accepted_friendships, -> { where(status: true) },
           class_name: 'Friendship'
  # Associations
  # friendship.user => sender of request
  # friendship.friend => receiver of request
  # user.friends => friends invited by user(receivers of request)
  # user.friend_requests_sent => unconfirmed friendships (from sender side)
  # user.requests_sent_to => receivers(friends) of request
  # user.friend_requests_received => unconfirmed friendships (from receiver side)
  # user.requests_received_from => senders of request
  # user.accepted_friendships => accepted friendships(status:true)
end
