class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :show, :update, :destroy]
  before_action :admin_user, only: [:create, :new, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(set_params)
    if @post.save
      redirect_to posts_path
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
  end

  def update
    @post.update(set_params)
    if @post.save
      redirect_to posts_path
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path
    end
  end

  private

  def set_params
    params.require(:post).permit(:title, :category, :image, :text, :friendly_id_slugs, :publish)
  end

  def find_post
    @post = Post.friendly.find(params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
