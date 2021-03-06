class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by {|x| x.total_votes}.reverse
  end

  def show
    # default action is under set_post
    @comment = Comment.new # note this has to be inserted because comment is shown on the post page
    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.xml { render xml: @post }
    end
  end

  def new
    @post = Post.new
  end

  def create
    
    @post = Post.new(post_params) # note you can check this with binding.pry
    @post.user = current_user 

    if @post.save
      flash[:notice] = "Your post was successfully created."
      redirect_to posts_path # this would be the index page with all the posts listed
    else
      render "new" # note, you can also use symbols here eg :new or do it this way. Bottom line, be consistent
    end
  end

  def edit
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "Your post was updated."
      redirect_to post_path(@post)
    else
      render "edit"
    end

    # note: no delete action
  end

  def vote
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote]) # this last params here includes both up vote and down vote
    
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted"
        else
          flash[:error] = "You are only allowed to vote on a post once"
        end
        redirect_to :back 
      end
      format.js # leaving it blank will make it automatically look for the vote js view template
    end
  end

  private

  def post_params # for the create action - strong parameters
    params.require(:post).permit(:title, :url, :description, category_ids:[]) # permit ! permits everything, otherwise you can specify what you want to permit
  end

  def set_post # this is for the before_action above
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.user || current_user.admin?)
  end

end
