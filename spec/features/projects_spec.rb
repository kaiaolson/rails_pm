require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  let(:user) { FactoryGirl.create(:user) }

  describe "Create Project" do
    before { login_via_web(user) }

    it "dsiplays project show page / it displays the text 'project created successfully'" do
      visit new_project_path

      project = FactoryGirl.attributes_for(:project)

      fill_in "Title", with: project[:title]
      fill_in "Description", with: project[:description]

      click_button "Create Project"

      expect(current_path).to eq(project_path(Project.last.friendly_id))
      expect(page).to have_text /project created successfully/i
    end
  end
end
