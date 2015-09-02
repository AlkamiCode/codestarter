class NotificationsController < ApplicationController
  def create
    NotificationsMailer.contact(email_params).deliver_now
    redirect_to :back, notice: "Email sent."
  end

  private

  def email_params
    params.permit(:name, :email, :message)
  end
end
