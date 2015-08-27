class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.username}!"
      redirect_to :back
    else
      flash[:danger] = "Need Username and Password"
      redirect_to :back
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  def update
    binding.pry
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
