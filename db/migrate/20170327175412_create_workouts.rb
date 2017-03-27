class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.date :workout_date
      t.decimal :distance
      t.integer  :runner_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
