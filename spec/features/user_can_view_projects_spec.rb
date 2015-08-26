require 'rails_helper'

RSpec.feature "UserCanViewProjects", type: :feature do
  let!(:project) { Fabricate(:project) }
  let!(:project_2) { Fabricate(:project, name: "Second Project") }

  it "can view all projects from the projects page" do
    visit projects_path
    expect(page).to have_content("Sample Project")
    expect(page).to have_content("Second Project")
    expect(page).to have_content("To make the sample world a better place.")
    expect(page).to have_content("Current Funding: $200.00")
    expect(page).to have_content("Current Funding: $200.00")
  end
end
