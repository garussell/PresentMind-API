class PatternSerializer
  include JSONAPI::Serializer

  def self.create_stats(patient, pattern)
    {
      pattern_id: pattern.id,
      pattern: {
        appointments: {
          average_mood_before_appointment: pattern.average_mood_before_appointment,
          average_mood_after_appointment: pattern.average_mood_after_appointment,
          average_stress_before_appointment: pattern.average_stress_before_appointment,
          average_stress_after_appointment: pattern.average_stress_after_appointment
        },
        exercise_entries: {
          average_mood_before_exercise: pattern.average_mood_before_exercise,
          average_mood_after_exercise: pattern.average_mood_after_exercise,
          average_stress_before_exercise: pattern.average_stress_before_exercise,
          average_stress_after_exercise: pattern.average_stress_after_exercise
        },
        journal_entries: {
          average_mood_before_journal: pattern.average_mood_before_journal,
          average_mood_after_journal: pattern.average_mood_after_journal,
          average_stress_before_journal: pattern.average_stress_before_journal,
          average_stress_after_journal: pattern.average_stress_after_journal
        },
        medication_entries: {
          average_mood_before_medication: pattern.average_mood_before_medication,
          average_mood_after_medication: pattern.average_mood_after_medication,
          average_stress_before_medication: pattern.average_stress_before_medication,
          average_stress_after_medication: pattern.average_stress_after_medication
        },
        mindfulness_activities: {
          average_mood_before_mindfulness_activity: pattern.average_mood_before_mindfulness_activity,
          average_mood_after_mindfulness_activity: pattern.average_mood_after_mindfulness_activity,
          average_stress_before_mindfulness_activity: pattern.average_stress_before_mindfulness_activity,
          average_stress_after_mindfulness_activity: pattern.average_stress_after_mindfulness_activity
        },
        nutrition_entries: {
          average_mood_before_nutrition: pattern.average_mood_before_nutrition,
          average_mood_after_nutrition: pattern.average_mood_after_nutrition,
          average_mood_after_incorrect_portion_unhealthy: pattern.average_mood_after_incorrect_portion_unhealthy,
          average_mood_after_incorrect_portion_healthy: pattern.average_mood_after_incorrect_portion_healthy,
          average_mood_after_correct_portion_unhealthy: pattern.average_mood_after_correct_portion_unhealthy, 
          average_mood_after_correct_portion_healthy: pattern.average_mood_after_correct_portion_healthy,
          average_stress_before_nutrition: pattern.average_stress_before_nutrition,
          average_stress_after_nutrition: pattern.average_stress_after_nutrition,
          average_stress_after_incorrect_portion_unhealthy: pattern.average_stress_after_incorrect_portion_unhealthy,
          average_stress_after_incorrect_portion_healthy: pattern.average_stress_after_incorrect_portion_healthy,
          average_stress_after_correct_portion_unhealthy: pattern.average_stress_after_correct_portion_unhealthy,
          average_stress_after_correct_portion_healthy: pattern.average_stress_after_correct_portion_healthy,

        },
        sleep_entries: {
          average_mood_before_sleep: pattern.average_mood_before_sleep,
          average_mood_after_sleep: pattern.average_mood_after_sleep,
          average_mood_after_dreams: pattern.average_mood_after_dreams,
          average_mood_after_no_dreams: pattern.average_mood_after_no_dreams,
          average_mood_less_than_8_hours: pattern.average_mood_less_than_8_hours,
          average_mood_8_hours: pattern.average_mood_8_hours,
          average_stress_before_sleep: pattern.average_stress_before_sleep,
          average_stress_after_sleep: pattern.average_stress_after_sleep,
          average_stress_after_dreams: pattern.average_stress_after_dreams,
          average_stress_after_no_dreams: pattern.average_stress_after_no_dreams
        },
        social_interactions: {
          average_mood_before_social_interaction: pattern.average_mood_before_social_interaction,
          average_mood_after_social_interaction: pattern.average_mood_after_social_interaction,
          average_mood_after_social_with_alcohol_no_drugs: pattern.average_mood_after_social_with_alcohol_no_drugs,
          average_mood_after_social_with_drugs_no_alcohol: pattern.average_mood_after_social_with_drugs_no_alcohol,
          average_mood_after_social_with_alcohol_and_drugs: pattern.average_mood_after_social_with_alcohol_and_drugs,
          average_mood_after_social_with_no_alcohol_no_drugs: pattern.average_mood_after_social_with_no_alcohol_no_drugs,
          average_stress_before_social_interaction: pattern.average_stress_before_social_interaction,
          average_stress_after_social_interaction: pattern.average_stress_after_social_interaction,
          average_stress_after_social_with_alcohol_no_drugs: pattern.average_stress_after_social_with_alcohol_no_drugs,
          average_stress_after_social_with_drugs_no_alcohol: pattern.average_stress_after_social_with_drugs_no_alcohol,
          average_stress_after_social_with_alcohol_and_drugs: pattern.average_stress_after_social_with_alcohol_and_drugs,
          average_stress_after_social_with_no_alcohol_no_drugs: pattern.average_stress_after_social_with_no_alcohol_no_drugs
        },
      }
    }
  end
end