require "rails_helper"
RSpec.describe Project, type: :model do
  context "a valid project" do
    let!(:project) { Fabricate(:project) }

    it "has a name" do
      expect(project.name).to eq "Sample Project"
    end

    it "has a description" do
      expect(project.description).to eq "To make the sample world a better place."
    end

    it "has an image" do
      expect(project.image).to eq "hello.lpg"
    end

    it "is associated to a company" do
      expect(project.company_id).to eq 1
    end

    it "has a current funding level" do
      expect(project.current_funding).to eq 200
    end

    it "has a funding goal" do
      expect(project.funding_goal).to eq 500
    end

    it "has an end date" do
      expect(project.end_date).to eq "2015-12-12"
    end

    it "has a funding percentage level" do
      expect(project.funding_in_percentage).to eq 40
    end
  end

  context "an invalid project" do
    let(:project) { Fabricate.build(:project, name: nil) }

    it "does not have a name" do
      project.name = nil
      expect(project).to_not be_valid
    end

    it "does not have a description" do
      project.description = nil
      expect(project).to_not be_valid
    end

    it "does not have an image" do
      project.image = nil
      expect(project).to_not be_valid
    end

    it "does not have an associated company" do
      project.company_id = nil
      expect(project).to_not be_valid
    end

    it "does not have a current funding level" do
      project.current_funding = nil
      expect(project).to_not be_valid
    end

    it "does not have a funding goal" do
      project.funding_goal = nil
      expect(project).to_not be_valid
    end

    it "does not have an end date" do
      project.end_date = nil
      expect(project).to_not be_valid
    end
  end
end
