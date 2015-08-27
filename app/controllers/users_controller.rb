class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      if @user.role == 0
        redirect_to :back
      else
        redirect_to :back
      end
    else
      flash[:error] = "Need Username and Password"
      render :back
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
