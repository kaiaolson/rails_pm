require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:project) { FactoryGirl.create(:project) }

    describe "#new" do
      before do
        get :new
      end
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "instantiates a new Project and sets it equal to @project" do
        expect(assigns(:project)).to be_a_new(Project)
      end
    end

    describe "#create" do
      context "with valid attributes" do
        def valid_request
          post :create, project: {title: "test project title", description: "test description", due_date: "2016-04-04"}
        end
        it "creates a record in the database" do
          project_count_before = Project.count
          valid_request
          project_count_after = Project.count
          expect(project_count_after - project_count_before).to eq(1)
        end
        it "redirects to the project show page" do
          valid_request
          expect(response).to redirect_to(project_path(Project.last))
        end
        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do
        def invalid_request
          post :create, project: {title: "short", description: "test description", due_date: "2016-04-04"}
        end
        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
        it "doesn't create a record in the database" do
          project_count_before = Project.count
          invalid_request
          project_count_after = Project.count
          expect(project_count_after - project_count_before).to eq(0)
        end
        it "sets a flash alert message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end

    end

    describe "#show" do
      before do
        project
        get :show, id: project.id
      end
      it "renders the show template" do
        expect(response).to render_template(:show)
      end
      it "finds the record by id and sets it equal to the @project instance variable" do
        expect(assigns(:project)).to eq(project)
      end
      it "raises an error if the id passed doesn't match an id in the database" do
        expect { get :show, id: 93024893028}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "#index" do
      before do
        get :index
      end
      it "renders the index template" do
        expect(response).to render_template(:index)
      end
      it "fetches all records and sets them equal to the @projects instance variable" do
        p1 = FactoryGirl.create(:project)
        p2 = FactoryGirl.create(:project)
        expect(assigns(:projects)).to eq([p1, p2])
      end
    end

    describe "#edit" do
      before do
        project
        get :edit, id: project.id
      end
      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
      it "finds the record by id and sets it equal to the @project instance variable" do
        expect(assigns(:project)).to eq(project)
      end
    end

    describe "#update" do
      context "with valid attributes" do
        def valid_request
          patch :update, id: project.id, project: {title: "new project title"}
        end
        it "redirects to the show template" do
          valid_request
          expect(response).to redirect_to(project_path(project))
        end
        it "updates the record with new params" do
          valid_request
          expect(project.reload.title).to eq("new project title")
        end
        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do
        def invalid_request
          patch :update, id: project.id, project: {title: "short"}
        end
        it "renders the edit template" do
          invalid_request
          expect(response).to render_template(:edit)
        end
        it "doesn't update the record" do
          title_before = project.title
          invalid_request
          title_after = project.title
          expect(title_before).to eq(title_after)
        end
        it "sets a flash alert message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end

    describe "#destroy" do
      it "redirects to the index page" do
        delete :destroy, id: project
        expect(response).to redirect_to(projects_path)
      end
      it "destroys the record" do
        project
        project_count_before = Project.count
        delete :destroy, id: project
        project_count_after = Project.count
        expect(project_count_before - project_count_after).to eq(1)
      end
      it "sets a flash notice message" do
        delete :destroy, id: project
        expect(flash[:notice]).to be
      end
    end

end
