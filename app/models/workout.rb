class Workout < ActiveRecord::Base
  belongs_to :runner

  validates :workout_date, :distance, presence: true

  def self.all_workouts_by_runner_id_rev_chron(id)
    self.where("runner_id = ?", id).order("workout_date DESC")
  end

  def self.rankings(gender,period)
    case period
      when "All Time"
        start_date = 0
      when "This Year"
        start_date = Time.now.beginning_of_year
      when "This Month"
        start_date = Time.now.beginning_of_month
    end
    query_results = self.where("gender = ? AND workout_date >= ?", gender, start_date).joins("INNER JOIN runners ON runners.id = workouts.runner_id")
    self.format_query_results_into_rankings(query_results)
  end

  def self.format_query_results_into_rankings(query_results)
    total_mileage_by_runner_id = Hash.new(0)
    query_results.each{|workout| total_mileage_by_runner_id[workout.runner_id] += workout.distance}
    total_mileage_by_runner = total_mileage_by_runner_id.sort_by{|runner_id, mileage| mileage}.reverse
    total_mileage_by_runner.collect{|runner_data| runner_data.insert(1,Runner.find_by_id(runner_data[0]).name)}
  end

end
