class CommentsController < ApplicationController
  def create
    @comment = Comment.new( params[:comment] )
    @comment.user_id = current_user.id
    
    if @comment.save!
      UserNotify.new_comment(@comment).deliver 
    end
    

    redirect_to polymorphic_path(@comment.commentable) + "#c#{@comment.id.to_s}"
    #redirect_to request.referrer
    #render :text => ap(params)
  end
end
