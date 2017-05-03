class IssuesController < ApplicationController

  def show
    
  end

  def index
    @issues = Issue.all
  end

end