class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params)
		
			if @comment.save
					respond_to do |format|
							format.js do
								render(
									partial: 'create_comment',
									locals: { resource: @comment })
							end
					end
			end
	end

  def comment_params
    params.require(:comment).permit(:issue_id, :text)
  end

end
