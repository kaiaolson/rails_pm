require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  describe "Visit Home Page" do
    it "displays an h1 'Welcome to my Rails Project Management App'" do
      visit root_path
      expect(page).to have_selector "h1", text: /Welcome to my Rails Project Management App/i
    end
  end
end
