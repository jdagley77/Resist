class IssuesController < ApplicationController
  include DocusignHelper
  def show
    @issue = Issue.find(params[:id])
    @user = @issue.user
  end

  def index
    @issues = Issue.all
  end

  def sign
    @issue = Issue.last
    @user = current_user
    redirect_to docusign_post_requests(@user, @issue)
  end

end
