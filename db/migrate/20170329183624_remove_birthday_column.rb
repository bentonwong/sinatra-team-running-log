class RemoveBirthdayColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :runners, :birthday
  end
end
