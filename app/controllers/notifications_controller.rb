class NotificationsController < ApplicationController
  def create
    NotificationsMailer.contact(email_params).deliver_now
  end

  private

  def email_params
    params.permit(:name, :email, :message)
  end
end
