require 'factory_bot_rails'
require 'faker'

Therapist.destroy_all
Patient.destroy_all
Appointment.destroy_all
ExerciseEntry.destroy_all
JournalEntry.destroy_all
MedicationEntry.destroy_all
MindfulnessActivity.destroy_all
NutritionEntry.destroy_all
SleepEntry.destroy_all
SocialInteraction.destroy_all
Pattern.destroy_all

therapist1 = FactoryBot.create(:therapist)
therapist2 = FactoryBot.create(:therapist)
puts "Therapists created"

patient1 = FactoryBot.create(:patient, therapist: therapist1)

FactoryBot.create_list(:appointment, 5, patient: patient1)
FactoryBot.create_list(:exercise_entry, 5, patient: patient1)
FactoryBot.create_list(:journal_entry, 5, patient: patient1)
FactoryBot.create_list(:medication_entry, 5, patient: patient1)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient1)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient1)
FactoryBot.create_list(:sleep_entry, 5, patient: patient1)
FactoryBot.create_list(:social_interaction, 5, patient: patient1)
FactoryBot.create_list(:pattern, 5, patient: patient1)

puts "Patient1 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

patient2 = FactoryBot.create(:patient, therapist: therapist1)

FactoryBot.create_list(:appointment, 5, patient: patient2)
FactoryBot.create_list(:exercise_entry, 5, patient: patient2)
FactoryBot.create_list(:journal_entry, 5, patient: patient2)
FactoryBot.create_list(:medication_entry, 5, patient: patient2)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient2)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient2)
FactoryBot.create_list(:sleep_entry, 5, patient: patient2)
FactoryBot.create_list(:social_interaction, 5, patient: patient2)
FactoryBot.create_list(:pattern, 5, patient: patient2)

puts "Patient2 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

patient3 = FactoryBot.create(:patient, therapist: therapist1)

FactoryBot.create_list(:appointment, 5, patient: patient3)
FactoryBot.create_list(:exercise_entry, 5, patient: patient3)
FactoryBot.create_list(:journal_entry, 5, patient: patient3)
FactoryBot.create_list(:medication_entry, 5, patient: patient3)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient3)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient3)
FactoryBot.create_list(:sleep_entry, 5, patient: patient3)
FactoryBot.create_list(:social_interaction, 5, patient: patient3)
FactoryBot.create_list(:pattern, 5, patient: patient3)

puts "Patient3 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

patient4 = FactoryBot.create(:patient, therapist: therapist1)

FactoryBot.create_list(:appointment, 5, patient: patient4)
FactoryBot.create_list(:exercise_entry, 5, patient: patient4)
FactoryBot.create_list(:journal_entry, 5, patient: patient4)
FactoryBot.create_list(:medication_entry, 5, patient: patient4)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient4)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient4)
FactoryBot.create_list(:sleep_entry, 5, patient: patient4)
FactoryBot.create_list(:social_interaction, 5, patient: patient4)
FactoryBot.create_list(:pattern, 5, patient: patient4)

puts "Patient4 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

patient5 = FactoryBot.create(:patient, therapist: therapist1)

FactoryBot.create_list(:appointment, 5, patient: patient5)
FactoryBot.create_list(:exercise_entry, 5, patient: patient5)
FactoryBot.create_list(:journal_entry, 5, patient: patient5)
FactoryBot.create_list(:medication_entry, 5, patient: patient5)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient5)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient5)
FactoryBot.create_list(:sleep_entry, 5, patient: patient5)
FactoryBot.create_list(:social_interaction, 5, patient: patient5)
FactoryBot.create_list(:pattern, 5, patient: patient5)

puts "Patient5 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

# Therapist 2 Patients

patient6 = FactoryBot.create(:patient, therapist: therapist2)

FactoryBot.create_list(:appointment, 5, patient: patient6)
FactoryBot.create_list(:exercise_entry, 5, patient: patient6)
FactoryBot.create_list(:journal_entry, 5, patient: patient6)
FactoryBot.create_list(:medication_entry, 5, patient: patient6)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient6)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient6)
FactoryBot.create_list(:sleep_entry, 5, patient: patient6)
FactoryBot.create_list(:social_interaction, 5, patient: patient6)
FactoryBot.create_list(:pattern, 5, patient: patient6)

puts "Patient6 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

patient7 = FactoryBot.create(:patient, therapist: therapist2)

FactoryBot.create_list(:appointment, 5, patient: patient7)
FactoryBot.create_list(:exercise_entry, 5, patient: patient7)
FactoryBot.create_list(:journal_entry, 5, patient: patient7)
FactoryBot.create_list(:medication_entry, 5, patient: patient7)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient7)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient7)
FactoryBot.create_list(:sleep_entry, 5, patient: patient7)
FactoryBot.create_list(:social_interaction, 5, patient: patient7)
FactoryBot.create_list(:pattern, 5, patient: patient7)

puts "Patient7 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

patient8 = FactoryBot.create(:patient, therapist: therapist2)

FactoryBot.create_list(:appointment, 5, patient: patient8)
FactoryBot.create_list(:exercise_entry, 5, patient: patient8)
FactoryBot.create_list(:journal_entry, 5, patient: patient8)
FactoryBot.create_list(:medication_entry, 5, patient: patient8)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient8)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient8)
FactoryBot.create_list(:sleep_entry, 5, patient: patient8)
FactoryBot.create_list(:social_interaction, 5, patient: patient8)
FactoryBot.create_list(:pattern, 5, patient: patient8)

puts "Patient8 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

patient9 = FactoryBot.create(:patient, therapist: therapist2)

FactoryBot.create_list(:appointment, 5, patient: patient9)
FactoryBot.create_list(:exercise_entry, 5, patient: patient9)
FactoryBot.create_list(:journal_entry, 5, patient: patient9)
FactoryBot.create_list(:medication_entry, 5, patient: patient9)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient9)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient9)
FactoryBot.create_list(:sleep_entry, 5, patient: patient9)
FactoryBot.create_list(:social_interaction, 5, patient: patient9)
FactoryBot.create_list(:pattern, 5, patient: patient9)

puts "Patient9 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

patient10 = FactoryBot.create(:patient, therapist: therapist2)

FactoryBot.create_list(:appointment, 5, patient: patient10)
FactoryBot.create_list(:exercise_entry, 5, patient: patient10)
FactoryBot.create_list(:journal_entry, 5, patient: patient10)
FactoryBot.create_list(:medication_entry, 5, patient: patient10)
FactoryBot.create_list(:mindfulness_activity, 5, patient: patient10)
FactoryBot.create_list(:nutrition_entry, 5, patient: patient10)
FactoryBot.create_list(:sleep_entry, 5, patient: patient10)
FactoryBot.create_list(:social_interaction, 5, patient: patient10)
FactoryBot.create_list(:pattern, 5, patient: patient10)

puts "Patient10 created with appointments, exercise_entries, journal_entries, medication_entries, mindfulness_activities, nutrition_entries, sleep_entries, social_interactions, and patterns"

