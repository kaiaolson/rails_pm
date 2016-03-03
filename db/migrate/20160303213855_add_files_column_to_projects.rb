class AddFilesColumnToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :files, :string, array: true, default: []
  end
end
