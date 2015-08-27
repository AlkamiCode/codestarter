require "rails_helper"

RSpec.feature User, type: :feature do
  let!(:project)   { Fabricate(:project) }
  let!(:project_2) { Fabricate(:project, name: "second name") }
  let!(:project_3) { Fabricate(:project, name: "third name") }
  let!(:project_4) { Fabricate(:project, name: "fourth name") }
  let!(:project_5) { Fabricate(:project, name: "fifth name") }
  let!(:project_6) { Fabricate(:project, name: "sixth name") }

  scenario "views featured projects on home page" do
    visit root_path

    expect(page).to have_link(project.name)
  end

  scenario "visits featured projects show page" do
    visit root_path

    click_link(project_2.name)

    expect(current_path).to eq project_path(project_2.id)
    expect(page).to have_content(project_2.name)
  end
end
