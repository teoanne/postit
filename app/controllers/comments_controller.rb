class CommentsController < ApplicationController
  before_action :require_user
  

  def create
    @post = Post.find(params[:post_id]) # why post_id and not id? because if you check params under binding.pry for this section, you see post_id listed and not just id
    @comment = @post.comments.build(params.require(:comment).permit(:body)) # build = creates it in memory
    @comment.user = current_user

    if @comment.save # save saves it into the database
      flash[:notice] = "Your comment was successfully created."
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

end