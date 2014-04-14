class CommentsController < ApplicationController
  before_action :require_user

  def index
    # @comment = Comment.all.sort_by{|c| c.total_votes}.reverse
  end
  
  def create
    @post = Post.find_by(slug: params[:post_id]) # why post_id and not id? because if you check params under binding.pry for this section, you see post_id listed and not just id
    @comment = @post.comments.build(params.require(:comment).permit(:body)) # build = creates it in memory
    @comment.user = current_user

    if @comment.save # save saves it into the database
      flash[:notice] = "Your comment was successfully created."
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def vote
    @comment = Comment.find(params[:id]) # turned this into an instance variable because we need to access it in the vote.js.erb view file
    @vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote]) #not model backed so no need @vote instance variable

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted"
        else
          flash[:error] = "You are only allowed to vote on a comment once"
        end
          redirect_to :back
      end
      format.js # leaving it blank will make it automatically look for the vote js view template
    end # ends respond_to block
  end # ends vote action

end # ends class CommentsController