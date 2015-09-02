module ApplicationHelper
  def display_username
    current_user.username if current_user
  end

  def display_user_email
    current_user.email if current_user
  end
end
