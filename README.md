# Present Mind

This is a therapy tracker app that is currently in development.  The plan is to have two user roles (patient, therapist) and use `AuthO` and `Okta` for user authentication.  This application will not use `bcrypt` and password_digest to practice using auth servers for secure logins.  

### Planned Features
Models:
1. Patient Profile (MVP) - create patient model (name, email, dob, phone, address, emergency_contact, emergency_phone, therapist_id (foreign key)) "belongs_to" therapist.
2. Therapist Profile - create therapist model (name, specialization, credentials) "has_many" patients.

Patient Profiles: 
1. Mood Tracking - create mood model to store mood entries (patient_id (foreign key), current_mood_scale, stress_level (scale), notes, date)
2. Nutrition - create nutrition model to store nutrition entries (patient_id (foreign key), food_item, quantity, healthy:boolean, cups_of_water, fruits_and_veg_servings (5 is good), correct_portion:boolean, date)
3. Exercise - create exercise model to store fitness goals and exercise entries (patient_id (foreign key), goal, exercise_type (aerobic/anaerobic enum), total_minutes)
4. Journaling - create a JournalEntry model (patient_id, title, content, date)
5. Appointment/Calendar Tracking - Appointment model (patient_id, title, description, start_time, end_time)
6. Patterns/Trends - a way for users to track their moods/progress over time (date_range, average_mood, average_stress_level, average_stress_before_exercise, average_stress_after_exercise, average_mood_with_good_nutrition, average_mood_with_bad_nutrition, average_mood_before_journaling, average_mood_after_journaling, ...)

Therapist Profiles:
1. Patient Analysis - graphs with data correlating mood entries, with behaviors (nutrition, exercise, journaling) and insights into triggers/patterns
2. Appointment/Calendar Tracking - same as patient but includes all patients

Authorization:
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

## Endpoints

`?` - work in progress

## Deployment

- Docker and Google for back-end