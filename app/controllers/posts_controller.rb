class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts = []
    current_user.posts.each do |post|
      @timeline_posts << post
    end
    current_user.active_friends.each do |friend|
      friend.posts.each do |post|
        @timeline_posts << post
      end
    end
    @timeline_posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
