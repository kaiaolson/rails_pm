require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "validations" do
    it "requires a title" do
      p = Project.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end
    it "requires a unique title" do
      Project.create({title: "test"})
      p = Project.new(title: "test")
      p.valid?
      expect(p.errors).to have_key(:title)
    end
    it "doesn't allow due dates before today's date" do
      p = Project.new(due_date: "2016-01-01")
      p.valid?
      expect(p.errors).to have_key(:due_date)
    end
  end
end
