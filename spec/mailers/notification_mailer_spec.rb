require "rails_helper"
require "capybara/rails"

RSpec.describe NotificationMailer, type: :mailer do
  context "when a user registers" do
    let(:user) { Fabricate.build(:user) }

    it "receives an email confirming successful registration" do
      user.save!
      NotificationMailer.contact(user.email, "register").deliver_now
      email = ActionMailer::Base.deliveries.last

      expect(email.to.first).to eq(user.email)
      expect(email.subject).to eq("Welcome to CodeStarter")
    end
  end
end
