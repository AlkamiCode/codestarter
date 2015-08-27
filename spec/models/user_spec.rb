require "rails_helper"
RSpec.describe User, type: :model do
  context "with valid params" do
    let!(:user) { User.create!(valid_params) }

    it "creates a user with valid params" do
      expect(user).to be_valid
    end
  end

  context "with invalid params" do
    it "will not create a user without a password" do
      user = User.create(username: "Drewby")
      expect(user).to_not be_valid
    end

    it "will not create a user without a username" do
      user = User.create(password: "password")
      expect(user).to_not be_valid
    end

    it "does not permit duplicate usernames" do
      user = User.create(valid_params)
      user = User.create(valid_params)
      expect(user).to_not be_valid
    end
  end

  private

  def valid_params
    { username: "Drewby", password: "password" }
  end
end
