class ChangeUsernameToEmail < ActiveRecord::Migration[5.1]
  def change
    rename_column :runners, :username, :email
  end
end
