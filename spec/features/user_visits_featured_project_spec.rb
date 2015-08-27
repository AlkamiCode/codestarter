require "rails_helper"

RSpec.feature User, type: :feature do
  let!(:project) { Fabricate(:project) }
  let!(:project_2) { Fabricate(:project, name: "second name") }
  let!(:project_3) { Fabricate(:project, name: "third name") }

  scenario "views featured projects on home page" do
    visit root_path

    expect(page).to have_link(project.name)
  end

  scenario "visits featured projects show page" do
  end
end
