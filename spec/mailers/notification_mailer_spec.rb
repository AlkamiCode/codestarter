require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  let(:user) { Fabricate.build(:user) }

  context "when a user registers" do
    it "receives an email confirming successful registration" do
      user.save!
      NotificationMailer.contact(user.email).deliver_now
      email = ActionMailer::Base.deliveries.last

      expect(email.to.first).to eq(user.email)
      expect(email.subject).to eq("Welcome to CodeStarter")
    end
  end

  context "when a user is added as a collaborator" do
    it "receives an email confirming that they were added as collaborator" do
      user.save!
      NotificationMailer.contact(user.email).deliver_now
      email = ActionMailer::Base.deliveries.last

      expect(email.to.first).to eq(user.email)
      expect(email.subject).to eq("Welcome to CodeStarter")
    end
  end

  context "when a user funds the project" do
    it "receives an email confirming that they successfully funded the project" do
      user.save!
      NotificationMailer.contact(user.email).deliver_now
      email = ActionMailer::Base.deliveries.last

      expect(email.to.first).to eq(user.email)
      expect(email.subject).to eq("Welcome to CodeStarter")
    end
  end
end
