class NotificationMailer < ApplicationMailer
  def contact(email, type)
    msg = {
      "register"      => "Thanks for signing up, we hope you find some great projects to fund!",
      "collaborator"  => "You have been added as a collaborator.",
      "checkout"      => "You have successfully funded projects at CodeStarter."
    }

    @message = msg[type]

    mail(
      to:       email,
      subject:  "Welcome to CodeStarter"
    )
  end
end
