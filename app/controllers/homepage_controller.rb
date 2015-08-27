class HomepageController < ApplicationController
  def index
    @projects = Project.all.sample(6)
  end
end
