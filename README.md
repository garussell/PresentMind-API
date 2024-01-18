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

MindfullnessActivities {
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

SocialInteractions {
	id integer pk increments
	patient_id integer >* patients.id
	activity_type string
	participants integer
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
	average_mood_before_social_int integer
	average_mood_after_social_int integer
}
```

## Endpoints

`?` - work in progress

## Deployment

- Docker and Google for back-end