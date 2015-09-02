class NotificationMailer < ApplicationMailer
  def contact(email)
    @message = "Thanks for signing up, we hope you find some great projects to fund!"

    mail(
      to:       email,
      subject:  "Welcome to CodeStarter"
    )
  end
end
