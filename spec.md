[x] Build an MVC Sinatra Application.

1. Has models for Runners and Workouts.
2. Has views for runners and workouts.
3. Has controllers for the application(ApplicationController), runners (RunnersController), workouts(WorkoutsController).

[x] Use ActiveRecord with Sinatra.

ActiveRecord and Sinatra are loaded up in the Gemfile and configure in config.ru.  ActiveRecord is used to create, update, edit, and delete records.  Sinatra is used to render the view pages.

[x] Use Multiple Models.

Has 2 models: (1) runners (2) workouts

[x] Use at least one has_many relationship

In the runners model, runners have many workouts.

[x] Must have user accounts. The user that created a given piece of content should be the only person who can modify that content.

Users can create accounts and content.  Only the user who created the content can edit or delete it.  Although other users can view the content, the ability to edit or delete it is disable for those other users.

[x] You should validate user input to ensure that bad data isn't created.

Create Runners requires users to provide name, email, password, gender.  User cannot leave name, email, or password blank and are required fields, which the user must provide input in order to proceed.  The application will also check to see if the email address provides is already in the database.  If the the email already exists, the user will be redirected to '/'.  Also, gender is selected by choosing a radio button; the radio button has only 2 choices and only 1 can be submitted, and it is a required field.

Create Workout requires users to provide workout date and distance.  The user can pick a date from a calendar or the date picker using HTML.  Also, the distance must be a number using HTML to validate.  These 2 are required fields.  The notes field is optional and puts a character limitation of 500 characters.  Edit Workout has the same methods to validate the data however, none of the fields are required.
