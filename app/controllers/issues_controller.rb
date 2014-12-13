class IssuesController < ApplicationController

	def index
		@issue = Issue.new
		@issues_targeted = Issue.where(target_user_id: params[:user_id])
		begin
			#binding.pry
			@user = User.find params[:user_id]
			if(@user.issues.count > 0)
					@issues = User.first.issues
			else
					@issues = []		
			end
		rescue ActiveRecord::RecordNotFound
			@issues = []
		end

	end

	def create
		@issue = Issue.new(issue_params)
		
		if @issue.save
			respond_to do |format|
				format.js do
					render(
						partial: 'create_issue',
						locals: { resource: @issue })
				end
			end
		end

	end

	def show
		@issue = Issue.find (params[:id])
		@comments = @issue.comments
		@comment = Comment.new
	end


  def issue_params
    params.require(:issue).permit(:user_id, :target_user_id, :text)
  end

end






  

