class ChangeFormatOfDueDateProjects < ActiveRecord::Migration
  def change
    def up
      add_column :projects, :due_date, :date
    end

    def down
      remove_column :projects, :due_date
    end
  end
end
