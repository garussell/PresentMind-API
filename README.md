# Present Mind

This is a therapy tracker app that is currently in development.  The plan is to have two user roles (patient, therapist) and use `AuthO` by `Okta` for user authentication.  This application will not use `bcrypt` and password_digest to practice using auth servers for secure logins.  The MVP will contain user authentication and patient profile with mood tracking.  

### Planned Features
Models:
1. Patient Profile (MVP) - create patient model (name, email, dob, phone, address, emergency_contact, emergency_phone, therapist_id (foreign key)) "belongs_to" therapist.
2. Therapist Profile - create therapist model (name, specialization, credentials) "has_many" patients.

Patient Profiles: 
1. Mood Tracking (MVP) - create `moods` model to store mood entries (patient_id (foreign key), current_mood_scale, stress_level (scale), notes, date)
2. NutritionEntry - create `NutritionEntries` model to store nutrition entries (patient_id (foreign key), food_item, number_of_servings, healthy:boolean, cups_of_water, fruits_and_veg_servings (5 is good), correct_portion:boolean, date)
3. ExerciseEntry - create `ExerciseEntries` model to store fitness goals and exercise entries (patient_id (foreign key), goal, exercise_type (aerobic/anaerobic enum), total_minutes)
4. JournalEntry - create a `JournalEntries` model (patient_id, title, content, date)
5. Appointment/Calendar Tracking - `Appointments` model (patient_id, title, description, start_time, end_time)
6. Mindfulness Practice - track intentional `mindfullness activities` (patient_id, date, total_minutes, notes)
7. SleepEntry - track `SleepEntries` (patient_id, date, quality_rating, total_hours, notes/dream)
8. Social Interactions - track `social interactions` (patient_id, date, activity_type, participants, location, duration)
9. Patterns/Trends - a way for users to track their moods/progress `patterns` over time via 'has_many :through' relationships (date_range, average_mood, average_stress_level, average_stress_before_exercise, average_stress_after_exercise, average_mood_with_good_nutrition, average_mood_with_bad_nutrition, average_mood_before_journaling, average_mood_after_journaling, ...)

Therapist Profiles:
1. Patient Analysis - graphs with data correlating mood entries, with behaviors (nutrition, exercise, journaling) and insights into triggers/patterns.  `has_many :patterns, through: :patients`
2. Appointment/Calendar Tracking - same as patient but includes all patients

Authorization (MVP):
- Use [AuthO](https://auth0.com/)

In lieu of a front-end, I use the following curl command in the terminal to receive a Bearer token.  The front-end application with have the responsibility to send a request to Auth0 to receive the `access_token`, which will be necessary to authenticate retrieval of data from this API:

Note: Auth0 will provide this command with your client_id and client_secret when you create an account with them.  Here, they are stored in `.env`.

```
curl --request POST \
  --url https://dev-g05vewm4v3p5lud5.us.auth0.com/oauth/token \
  --header 'content-type: application/json' \
  --data '{"client_id":"YOUR_CLIENT_ID","client_secret":"YOUR_CLIENT_SECRET","audience":"http://localhost:3000","grant_type":"client_credentials"}'
```
Auth0 also provides a Rubyist way of doing it, which is functionally the same as using `curl` however the response does not contain statistical analysis that comes with curl and is perceptively quicker.

Therefore, for testing, a 'shared_context' block was setup in `spec_helper` and `include_context` in every request spec file using Ruby.

Privacy/Security:
- work in progress

## Setup

`rails new present_mind -T -d="postgresql" --api`
`cd prersent_mind`
`bundle exec rails db:create`

### Gems

`gem "pry"`
`gem "rspec-rails"`
`gem "factory_bot_rails"` - Add `config.include FactoryBot::Syntax:Methods` to rails_helper in the config block.
`gem "faker"`
`gem "simplecov"` - Add `require 'simplecov'` and `SimpleCov.start` - to rails_helper
`gem "jsonapi-serializer`

After adding gems:
`bundle`
`rails g rspec:install`

## Schema

```
patients {
	id integer pk increments
	therapist_id integer *> Therapists.id
	name string
	email string
	dob date
	phone string
	address string
	emergency_contact_name string
	emergency_contact_number string
}

Therapists {
	id integer pk increments
	name string
	specialization string
	credentials string
        bio string
}

Moods {
	id integer pk increments
	patient_id integer >* patients.id
	current_mood_scale integer
	stress_level_scale integer
	notes text
	date date
}

NutritionEntries {
	id integer pk increments
	patient_id integer >* patients.id
	food_item string
	calories integer
	number_of_servings integer
	healthy boolean
	cups_of_water integer
	fruits_and_veg_servings integer
	correct_portion boolean
	date date
}

ExerciseEntries {
	id integer pk increments
	patient_id integer >* patients.id
	goal string
	exercise_type integer
	total_minutes integer
	date date
}

JournalEntries {
	id integer pk increments
	patient_id integer >* patients.id
	title string
	content string
	date date
}

Appointments {
	id integer pk increments
	patient_id integer >* patients.id
	title string
	description string
	start_time datetime
	end_time datetime
}

MindfulnessActivities {
	id integer pk increments
	patient_id integer >* patients.id
	activity string
	total_minutes integer
	notes string
	date date
}

SleepEntries {
	id integer pk increments
	patient_id integer >* patients.id
	bed_time time
	quality_rating integer
	total_hours integer
	dream boolean
	notes string
	date date
}

MedicationEntries {
        id integer pk increments
        patient_id integer >* patients.id
        name string
        purpose string
        dose string
        schedule string
}

SocialInteractions {
	id integer pk increments
	patient_id integer >* patients.id
	event_name string
	activity_type string
	social_rating integer
	location string
	duration_in_minutes integer
	date date
	alcohol_use boolean
	drug_use boolean
}

Patterns {
	id integer pk increments
	patient_id integer >* patients.id
	start_date date
	end_date date
	average_mood integer
	average_stress_level integer
	average_sleep_quality integer
	average_sleep_hours integer
	average_stress_before_exercise integer
	average_stress_after_exercise integer
	average_mood_with_good_nutrition integer
	average_mood_with_bad_nutrition integer
	average_mood_before_journaling integer
	average_mood_after_journaling integer
	average_mood_before_mindfullness integer
	average_mood_after_mindfullness integer
	average_stress_before_mindfullness integer
	average_stress_after_mindfullness integer
	average_mood_before_social_event integer
	average_mood_after_social_event integer
        average_mood_before_meds integer
        average_mood_after_meds integer
}
```
![Screenshot 2024-01-18 at 2 21 20 PM](https://github.com/garussell/PresentMind/assets/125214565/3579e338-d02f-4ae4-ba1c-37e14fb1d5a4)

## Endpoints

Patients:

`GET /api/v1/patients`: Retrieve a list of all patients.
`GET /api/v1/patients/:id`: Retrieve details of a specific patient.
`POST /api/v1/patients`: Create a new patient.
`PUT /api/v1/patients/:id`: Update details of a specific patient.
`DELETE /api/v1/patients/:id`: Delete a specific patient.

Therapists:

`GET /therapists`: Retrieve a list of all therapists.
`GET /therapists/:id`: Retrieve details of a specific therapist.
`POST /therapists`: Create a new therapist.
`PUT /therapists/:id`: Update details of a specific therapist.
`DELETE /therapists/:id`: Delete a specific therapist.

Nutrition Entries:

`GET /api/v1/patients/:patient_id/nutrition_entries`: Retrieve a list of all nutrition entries.
`GET /api/v1/patients/:patient_id/nutrition_entries/:id`: Retrieve details of a specific nutrition entry.
`POST /api/v1/patients/:patient_id/nutrition_entries`: Create a new nutrition entry.
`PUT /api/v1/patients/:patient_id/nutrition_entries/:id`: Update details of a specific nutrition entry.
`DELETE /api/v1/patients/:patient_id/nutrition_entries/:id`: Delete a specific nutrition entry.

Exercise Entries:

`GET /api/v1/patients/:patient_id/exercise_entries`: Retrieve a list of all exercise entries.
`GET /api/v1/patients/:patient_id/exercise_entries/:id`: Retrieve details of a specific exercise entry.
`POST /api/v1/patients/:patient_id/exercise_entries`: Create a new exercise entry.
`PUT /api/v1/patients/:patient_id/exercise_entries/:id`: Update details of a specific exercise entry.
`DELETE /api/v1/patients/:patient_id/exercise_entries/:id`: Delete a specific exercise entry.

Journal Entries:

`GET /api/v1/patients/:patient_id/journal_entries`: Retrieve a list of all journal entries.
`GET /api/v1/patients/:patient_id/journal_entries/:id`: Retrieve details of a specific journal entry.
`POST /api/v1/patients/:patient_id/journal_entries`: Create a new journal entry.
`PUT /api/v1/patients/:patient_id/journal_entries/:id`: Update details of a specific journal entry.
`DELETE /api/v1/patients/:patient_id/journal_entries/:id`: Delete a specific journal entry.

Appointments:

`GET /api/v1/patients/:patient_id/appointments`: Retrieve a list of all appointments.
`GET /api/v1/patients/:patient_id/appointments/:id`: Retrieve details of a specific appointment.
`POST /api/v1/patients/:patient_id/appointments`: Create a new appointment.
`PUT /api/v1/patients/:patient_id/appointments/:id`: Update details of a specific appointment.
`DELETE /api/v1/patients/:patient_id/appointments/:id`: Delete a specific appointment.

Mindfulness Activities:

`GET /api/v1/patients/:patient_id/mindfulness_activities`: Retrieve a list of all mindfulness activities.
`GET /api/v1/patients/:patient_id/mindfulness_activities/:id`: Retrieve details of a specific mindfulness activity.
`POST /api/v1/patients/:patient_id/mindfulness_activities`: Create a new mindfulness activity.
`PUT /api/v1/patients/:patient_id/mindfulness_activities/:id`: Update details of a specific mindfulness activity.
`DELETE /api/v1/patients/:patient_id/mindfulness_activities/:id`: Delete a specific mindfulness activity.

Sleep Entries:

`GET /api/v1/patients/:patient_id/sleep_entries`: Retrieve a list of all sleep entries.
`GET /api/v1/patients/:patient_id/sleep_entries/:id`: Retrieve details of a specific sleep entry.
`POST /api/v1/patients/:patient_id/sleep_entries`: Create a new sleep entry.
`PUT /api/v1/patients/:patient_id/sleep_entries/:id`: Update details of a specific sleep entry.
`DELETE /api/v1/patients/:patient_id/sleep_entries/:id`: Delete a specific sleep entry.

Medication Entries:

`GET /api/v1/patients/:patient_id/medication_entries`: Retrieve a list of all medication entries.
`GET /api/v1/patients/:patient_id/medication_entries/:id`: Retrieve details of a specific medication entry.
`POST /api/v1/patients/:patient_id/medication_entries`: Create a new medication entry.
`PUT /api/v1/patients/:patient_id/medication_entries/:id`: Update details of a specific medication entry.
`DELETE /api/v1/patients/:patient_id/medication_entries/:id`: Delete a specific medication entry.

Social Interactions:

`GET /api/v1/patients/:patient_id/social_interactions`: Retrieve a list of all social interactions.
`GET /api/v1/patients/:patient_id/social_interactions/:id`: Retrieve details of a specific social interaction.
`POST /api/v1/patients/:patient_id/social_interactions`: Create a new social interaction.
`PUT /api/v1/patients/:patient_id/social_interactions/:id`: Update details of a specific social interaction.
`DELETE /api/v1/patients/:patient_id/social_interactions/:id`: Delete a specific social interaction.

Patterns:

`GET /api/v1/patients/:patient_id/patterns`: Retrieve a list of all social interactions.

## Deployment

- Pending:  Use Docker and Google
