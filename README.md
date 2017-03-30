# Running Team Online Mileage Log by Benton Wong

This application allows members of running teams (e.g. running clubs, cross country, track teams) to enter mileage, date, and comments about their runs into an online, secure log.  Each member registers to receive their own individual account with password.  Only that member can create, edit, and delete their log entry.

The data entered by each member is available for other registered users to view.  The data is also used to populate a leaderboard that allows all users to see who has run the most miles by gender and by the current month, current year, and all time.

## Usage

New Users

  1) Go to '/signup'.
  2) Provide a valid name, email, password, and select gender.
  3) Select 'Sign Up'

Current Users

  To login, go to '/login' and fill in the required credentials.

  To create a new workout, go to '/workouts/new', and fill out the fields.

  To edit a workout, go to '/workouts, find the workout in your workouts list that you wish to edit by clicking on the hyperlink.  On that page, there is a link to edit that workout.  Also, if you wish to delete a workout, there is a link to delete it on that same page.

  To view the team leaderboard, go to '/leaderboard'.

  To logout, go to '/logout'.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bentonwong/sinatra-team-running-log. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
