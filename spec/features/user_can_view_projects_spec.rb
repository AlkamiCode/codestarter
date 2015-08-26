require 'rails_helper'

RSpec.feature "UserCanViewProjects", type: :feature do
  # let!(:company1) { Company.create!(name: "Ocean World", description: "the sea")}
  # let!(:company2) { Company.create!(name: "Turing", description: "teh codez")}
  let!(:project1) { Project.create!(name: "A name", description: "best project ever", current_funding: 500) }
  let!(:project2) { Project.create!(name: "Another project", description: "ok project", current_funding: 25) }

  it "can view all projects from the projects page" do
    visit projects_path
    expect(page).to have_content("A name")
    expect(page).to have_content("Another project")
    expect(page).to have_content("best project ever")
    expect(page).to have_content("ok project")
    expect(page).to have_content("Current Funding: $500.00")
    expect(page).to have_content("Current Funding: $25.00")
  end
end
