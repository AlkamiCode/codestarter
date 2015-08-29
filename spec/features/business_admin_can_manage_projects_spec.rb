require "rails_helper"

RSpec.feature "Business Admin Can Manage Projects", type: :feature do
  let!(:admin) { User.create!(username: "admin", password: "admin", password_confirmation: "admin") }

  context "as a business admin" do
    before do
     ApplicationController.any_instance.stubs(:current_user).returns(admin)
   end
  end
end
# As a business admin,
# when I visit "//projects" and click the "Delete" button on the first project card,
# that project will be deleted and I will still be on "//projects"
#
# As a business admin,
# when I visit "//projects" and click the "Edit" button on the first project card,
# I will be redirected to a page where I can edit the image, project name, project description, funding goal and funding end date,
# when I click "Update Project" I will be redirected to that project page,
# and on the project page there will be a link back to view all my projects.
