class RemoveFileColumnFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :file, :string
  end
end
