class SetDefaultForTaskStatus < ActiveRecord::Migration
  def change
    change_column :tasks, :status, :string, default: "Not Done"
  end
end
