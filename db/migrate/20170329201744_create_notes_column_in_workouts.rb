class CreateNotesColumnInWorkouts < ActiveRecord::Migration[5.1]
  def change
    add_column :workouts, :notes, :text
  end
end
