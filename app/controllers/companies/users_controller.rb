class Companies::UsersController < Companies::CompaniesController
  def index
  end

  def new
  end

  def create
    require 'pry'; binding.pry
  end

  def search
    @user = User.find_by(username: params[:searchfield])
    render :new
  end
end
