require 'rails_helper'

RSpec.describe Company, type: :model do
  context "a valid company" do
    let!(:company) { Fabricate(:company) }

    it "has a name" do
      expect(company.name).to eq "Sample Company"
    end

    it "has a description" do
      expect(company.description).to eq "We are a company that's building software."
    end
  end

  context "an invalid company" do
    let(:company) { Fabricate.build(:company) }

    it "it invalid without a name" do
      company.name = nil
      expect(company).not_to be_valid
    end

    it "is invalid without a description" do
      company.description = nil
      expect(company).not_to be_valid
    end

    it "has a unique name" do
      company.save
      company2 = Company.new(name: "Sample Company", description: "description")
      expect(company2).not_to be_valid
    end
  end
end
