class RemoveBirthdayColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :runners, :birthday
  end
end
