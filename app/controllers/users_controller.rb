class UsersController < ApplicationController
  def create
    @user = User.create(user_params)

    if @user
      @user.roles << Role.find_or_create_by(name: 'registered_user')
      session[:user_id] = @user.id
      send_registration_email(@user, "register")
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
    user = User.find(current_user.id)
    user.update(user_params)

    if user.save
      flash[:success] = "user info updated!"
      redirect_to :back
    else
      flash[:danger] = "Unable to update user"
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end

  def send_registration_email(user, type)
    NotificationMailer.contact(user.email, type).deliver_now
  end
end
