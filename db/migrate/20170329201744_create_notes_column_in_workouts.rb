class CreateNotesColumnInWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :notes, :text
  end
end
