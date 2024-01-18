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
	total_minutes integer
	notes string
	date date
}

SleepEntries {
	id integer pk increments
	patient_id integer >* patients.id
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
	activity_type string
	number_of_participants integer
	enjoyment_scale integer
	location string
	duration_in_minutes integer
	date date
}

Patterns {
	id integer pk increments
	patient_id integer >* patients.id
	start_date date
	end_date date
	average_mood integer
	average_stress_level integer
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

## Endpoints

Patients:

`GET /patients`: Retrieve a list of all patients.
`GET /patients/:id`: Retrieve details of a specific patient.
`POST /patients`: Create a new patient.
`PUT /patients/:id`: Update details of a specific patient.
`DELETE /patients/:id`: Delete a specific patient.

Therapists:

`GET /therapists`: Retrieve a list of all therapists.
`GET /therapists/:id`: Retrieve details of a specific therapist.
`POST /therapists`: Create a new therapist.
`PUT /therapists/:id`: Update details of a specific therapist.
`DELETE /therapists/:id`: Delete a specific therapist.

Moods:

`GET /moods`: Retrieve a list of all mood entries.
`GET /moods/:id`: Retrieve details of a specific mood entry.
`POST /moods`: Create a new mood entry.
`PUT /moods/:id`: Update details of a specific mood entry.
`DELETE /moods/:id`: Delete a specific mood entry.

Nutrition Entries:

`GET /nutrition_entries`: Retrieve a list of all nutrition entries.
`GET /nutrition_entries/:id`: Retrieve details of a specific nutrition entry.
`POST /nutrition_entries`: Create a new nutrition entry.
`PUT /nutrition_entries/:id`: Update details of a specific nutrition entry.
`DELETE /nutrition_entries/:id`: Delete a specific nutrition entry.

Exercise Entries:

`GET /patients/:patient_id/exercise_entries`: Retrieve a list of all exercise entries.
`GET /patients/:patient_id/exercise_entries/:id`: Retrieve details of a specific exercise entry.
`POST /patients/:patient_id/exercise_entries`: Create a new exercise entry.
`PUT /patients/:patient_id/exercise_entries/:id`: Update details of a specific exercise entry.
`DELETE /patients/:patient_id/exercise_entries/:id`: Delete a specific exercise entry.

Journal Entries:

`GET /patients/:patient_id/journal_entries`: Retrieve a list of all journal entries.
`GET /patients/:patient_id/journal_entries/:id`: Retrieve details of a specific journal entry.
`POST /patients/:patient_id/journal_entries`: Create a new journal entry.
`PUT /patients/:patient_id/journal_entries/:id`: Update details of a specific journal entry.
`DELETE /patients/:patient_id/journal_entries/:id`: Delete a specific journal entry.

Appointments:

`GET /patients/:patient_id/appointments`: Retrieve a list of all appointments.
`GET /patients/:patient_id/appointments/:id`: Retrieve details of a specific appointment.
`POST /patients/:patient_id/appointments`: Create a new appointment.
`PUT /patients/:patient_id/appointments/:id`: Update details of a specific appointment.
`DELETE /patients/:patient_id/appointments/:id`: Delete a specific appointment.

Mindfulness Activities:

`GET /patients/:patient_id/mindfulness_activities`: Retrieve a list of all mindfulness activities.
`GET /patients/:patient_id/mindfulness_activities/:id`: Retrieve details of a specific mindfulness activity.
`POST /patients/:patient_id/mindfulness_activities`: Create a new mindfulness activity.
`PUT /patients/:patient_id/mindfulness_activities/:id`: Update details of a specific mindfulness activity.
`DELETE /patients/:patient_id/mindfulness_activities/:id`: Delete a specific mindfulness activity.

Sleep Entries:

`GET /patients/:patient_id/sleep_entries`: Retrieve a list of all sleep entries.
`GET /patients/:patient_id/sleep_entries/:id`: Retrieve details of a specific sleep entry.
`POST /patients/:patient_id/sleep_entries`: Create a new sleep entry.
`PUT /patients/:patient_id/sleep_entries/:id`: Update details of a specific sleep entry.
`DELETE /patients/:patient_id/sleep_entries/:id`: Delete a specific sleep entry.

Medication Entries:

`GET /patients/:patient_id/medication_entries`: Retrieve a list of all medication entries.
`GET /patients/:patient_id/medication_entries/:id`: Retrieve details of a specific medication entry.
`POST /patients/:patient_id/medication_entries`: Create a new medication entry.
`PUT /patients/:patient_id/medication_entries/:id`: Update details of a specific medication entry.
`DELETE /patients/:patient_id/medication_entries/:id`: Delete a specific medication entry.

Social Interactions:

`GET /patients/:patient_id/social_interactions`: Retrieve a list of all social interactions.
`GET /patients/:patient_id/social_interactions/:id`: Retrieve details of a specific social interaction.
`POST /patients/:patient_id/social_interactions`: Create a new social interaction.
`PUT /patients/:patient_id/social_interactions/:id`: Update details of a specific social interaction.
`DELETE /patients/:patient_id/social_interactions/:id`: Delete a specific social interaction.

Patterns:

`GET Sleep Entries:

`GET /patients/:patient_id/sleep_entries`: Retrieve a list of all sleep entries.
`GET /patients/:patient_id/sleep_entries/:id`: Retrieve details of a specific sleep entry.
`POST /patients/:patient_id/sleep_entries`: Create a new sleep entry.
`PUT /patients/:patient_id/sleep_entries/:id`: Update details of a specific sleep entry.
`DELETE /patients/:patient_id/sleep_entries/:id`: Delete a specific sleep entry./patterns`: Retrieve a list of all patterns.
`GET Sleep Entries:

`GET /patients/:patient_id/sleep_entries`: Retrieve a list of all sleep entries.
`GET /patients/:patient_id/sleep_entries/:id`: Retrieve details of a specific sleep entry.
`POST /patients/:patient_id/sleep_entries`: Create a new sleep entry.
`PUT /patients/:patient_id/sleep_entries/:id`: Update details of a specific sleep entry.
`DELETE /patients/:patient_id/sleep_entries/:id`: Delete a specific sleep entry./patterns/:id`: Retrieve details of a specific pattern.
`POST Sleep Entries:

`GET /patients/:patient_id/sleep_entries`: Retrieve a list of all sleep entries.
`GET /patients/:patient_id/sleep_entries/:id`: Retrieve details of a specific sleep entry.
`POST /patients/:patient_id/sleep_entries`: Create a new sleep entry.
`PUT /patients/:patient_id/sleep_entries/:id`: Update details of a specific sleep entry.
`DELETE /patients/:patient_id/sleep_entries/:id`: Delete a specific sleep entry./patterns`: Create a new pattern.
`PUT Sleep Entries:

`GET /patients/:patient_id/sleep_entries`: Retrieve a list of all sleep entries.
`GET /patients/:patient_id/sleep_entries/:id`: Retrieve details of a specific sleep entry.
`POST /patients/:patient_id/sleep_entries`: Create a new sleep entry.
`PUT /patients/:patient_id/sleep_entries/:id`: Update details of a specific sleep entry.
`DELETE /patients/:patient_id/sleep_entries/:id`: Delete a specific sleep entry./patterns/:id`: Update details of a specific pattern.
`DELETE Sleep Entries:

`GET /patients/:patient_id/sleep_entries`: Retrieve a list of all sleep entries.
`GET /patients/:patient_id/sleep_entries/:id`: Retrieve details of a specific sleep entry.
`POST /patients/:patient_id/sleep_entries`: Create a new sleep entry.
`PUT /patients/:patient_id/sleep_entries/:id`: Update details of a specific sleep entry.
`DELETE /patients/:patient_id/sleep_entries/:id`: Delete a specific sleep entry./patterns/:id`: Delete a specific pattern.

## Deployment

- Pending:  Use Docker and Google