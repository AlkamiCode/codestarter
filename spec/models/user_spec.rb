require "rails_helper"
RSpec.describe User, type: :model do
  context "a registered user" do
    let!(:user) { Fabricate(:user) }

    it "is valid" do
      expect(user).to be_valid
    end

    it "does not have an associated company" do
      expect(user.company).to eq nil
    end
  end

  context "an invalid user" do
    let!(:user) { Fabricate(:user) }

    it "is invalid without a name" do
      user.username = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is invalid if the name is too short" do
      user.username = "R"
      expect(user).to_not be_valid
    end

    it "is invalid if the name is too long" do
      user.username = "R" * 26
      expect(user).to_not be_valid
    end

    it "is invalid if the password is too short" do
      user.password = "beep"
      expect(user).to_not be_valid
    end

    it "is invalid if the password is too short" do
      user.password = "b" * 26
      expect(user).to_not be_valid
    end

    it "is invalid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is invalid if the email is invalid" do
      user.email = "#$!!??gmail....com"
      expect(user).to_not be_valid

      user.email = "$%#&&#^^hello@gmailc.om"
      expect(user).to_not be_valid

      user.email = "$%#&&#^^hello#))((^^%$helloe@gmailc.om"
      expect(user).to_not be_valid
    end
  end

  context "a company admin" do
    let!(:company) { Fabricate(:company) }
    let!(:user) { Fabricate(:user,
                            company_id: company.id,
                            roles: %w(company_admin)) }

    it "has an associated company" do
      expect(user.company.name).to eq "Sample Company"
    end

    it "is a company admin" do
      expect(user.company_admin?).to eq true
    end
  end

  context "a collaborator" do
    let!(:company) { Fabricate(:company) }
    let!(:user) { Fabricate(:user,
                            company_id: company.id,
                            roles: %w(collaborator)) }

    it "has an associated company" do
      expect(user.company.name).to eq "Sample Company"
    end

    it "is a collaborator" do
      expect(user.collaborator?).to eq true
    end
  end

  context "a former collaborator" do
    let!(:company) { Fabricate(:company) }
    let!(:user) { Fabricate(:user,
                            company_id: company.id,
                            roles: %w(former_collaborator)) }

    it "has an associated company" do
      expect(user.company.name).to eq "Sample Company"
    end

    it "is a former collaborator" do
      expect(user.former_collaborator?).to eq true
    end
  end
end
