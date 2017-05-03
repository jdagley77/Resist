class IssuesController < ApplicationController

  def show
    @issue = Issue.find(params[:id])
    @user = @issue.user
  end

  def index
    @issues = Issue.all
  end

end