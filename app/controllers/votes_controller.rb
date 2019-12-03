class VotesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @vote = @comment.votes.create(author: current_user)
    redirect_to @post
  end

=begin
  def destroy
    Vote.find(params[:id]).destroy
  end
=end
end

