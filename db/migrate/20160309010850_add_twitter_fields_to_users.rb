class AddTwitterFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_token, :string
    add_column :users, :github_secret, :string
    add_column :users, :github_raw_data, :text
  end
end
