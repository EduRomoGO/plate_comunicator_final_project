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

end