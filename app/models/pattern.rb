class Pattern < ApplicationRecord
  belongs_to :patient, dependent: :destroy

  has_many :appointments, through: :patient
  has_many :exercise_entries, through: :patient
  has_many :journal_entries, through: :patient
  has_many :medication_entries, through: :patient
  has_many :mindfulness_activities, through: :patient
  has_many :nutrition_entries, through: :patient
  has_many :sleep_entries, through: :patient
  has_many :social_interactions, through: :patient

  ## Instance Methods
  
  # Appointment Averages
  def average_mood_before_appointment
    calculate_average(appointments, :mood_before)
  end

  def average_mood_after_appointment
    calculate_average(appointments, :mood_after)
  end

  def average_stress_before_appointment
    calculate_average(appointments, :stress_before)
  end

  def average_stress_after_appointment
    calculate_average(appointments, :stress_after)
  end

  # Exercise Averages
  def average_mood_before_exercise
    calculate_average(exercise_entries, :mood_before)
  end

  def average_mood_after_exercise
    calculate_average(exercise_entries, :mood_after)
  end

  def average_stress_before_exercise
    calculate_average(exercise_entries, :stress_before)
  end

  def average_stress_after_exercise
    calculate_average(exercise_entries, :stress_after)
  end

  # Journal Averages
  def average_mood_before_journal
    calculate_average(journal_entries, :mood_before)
  end

  def average_mood_after_journal
    calculate_average(journal_entries, :mood_after)
  end

  def average_stress_before_journal
    calculate_average(journal_entries, :stress_before)
  end

  def average_stress_after_journal
    calculate_average(journal_entries, :stress_after)
  end

  # Medication Averages
  def average_mood_before_medication
    calculate_average(medication_entries, :mood_before)
  end

  def average_mood_after_medication
    calculate_average(medication_entries, :mood_after)
  end

  def average_stress_before_medication
    calculate_average(medication_entries, :stress_before)
  end

  def average_stress_after_medication
    calculate_average(medication_entries, :stress_after)
  end

  # Mindfulness Averages
  def average_mood_before_mindfulness_activity
    calculate_average(mindfulness_activities, :mood_before)
  end

  def average_mood_after_mindfulness_activity
    calculate_average(mindfulness_activities, :mood_after)
  end

  def average_stress_before_mindfulness_activity
    calculate_average(mindfulness_activities, :stress_before)
  end

  def average_stress_after_mindfulness_activity
    calculate_average(mindfulness_activities, :stress_after)
  end

  # Nutrition Averages
  def average_mood_before_nutrition
    calculate_average(nutrition_entries, :mood_before)
  end

  def average_mood_after_nutrition
    calculate_average(nutrition_entries, :mood_after)
  end

  def average_mood_after_incorrect_portion_unhealthy
    calculate_average(nutrition_entries.select { |entry| entry.correct_portion == false && entry.healthy == false }, :mood_after)
  end

  def average_mood_after_incorrect_portion_healthy
    calculate_average(nutrition_entries.select { |entry| entry.correct_portion == false && entry.healthy == true }, :mood_after)
  end

  def average_mood_after_correct_portion_unhealthy
    calculate_average(nutrition_entries.select { |entry| entry.correct_portion == true && entry.healthy == false }, :mood_after)
  end

  def average_mood_after_correct_portion_healthy
    calculate_average(nutrition_entries.select { |entry| entry.correct_portion == true && entry.healthy == true }, :mood_after)
  end

  def average_stress_before_nutrition
    calculate_average(nutrition_entries, :stress_before)
  end

  def average_stress_after_nutrition  
    calculate_average(nutrition_entries, :stress_after)
  end

  def average_stress_after_incorrect_portion_unhealthy
    calculate_average(nutrition_entries.select { |entry| entry.correct_portion == false && entry.healthy == false }, :stress_after)
  end

  def average_stress_after_incorrect_portion_healthy
    calculate_average(nutrition_entries.select { |entry| entry.correct_portion == false && entry.healthy == true }, :stress_after)
  end

  def average_stress_after_correct_portion_unhealthy
    calculate_average(nutrition_entries.select { |entry| entry.correct_portion == true && entry.healthy == false }, :stress_after)
  end

  def average_stress_after_correct_portion_healthy
    calculate_average(nutrition_entries.select { |entry| entry.correct_portion == true && entry.healthy == true }, :stress_after)
  end

  # Sleep Averages
  def average_mood_before_sleep
    calculate_average(sleep_entries, :mood_before)
  end

  def average_mood_after_sleep
    calculate_average(sleep_entries, :mood_after)
  end

  def average_mood_after_dreams
    calculate_average(sleep_entries.select { |entry| entry.dream == true }, :mood_after)
  end

  def average_mood_after_no_dreams
    calculate_average(sleep_entries.select { |entry| entry.dream == false }, :mood_after)
  end

  def average_mood_less_than_8_hours
    calculate_average(sleep_entries.select { |entry| entry.total_hours < 8 }, :mood_after)
  end

  def average_mood_8_hours
    calculate_average(sleep_entries.select { |entry| entry.total_hours >= 8 }, :mood_after)
  end

  def average_stress_before_sleep
    calculate_average(sleep_entries, :stress_before)
  end

  def average_stress_after_sleep
    calculate_average(sleep_entries, :stress_after)
  end

  def average_stress_after_dreams
    calculate_average(sleep_entries.select { |entry| entry.dream == true }, :stress_after)
  end

  def average_stress_after_no_dreams
    calculate_average(sleep_entries.select { |entry| entry.dream == false }, :stress_after)
  end

  # Social Interaction Averages
  def average_mood_before_social_interaction
    calculate_average(social_interactions, :mood_before)
  end

  def average_mood_after_social_interaction 
    calculate_average(social_interactions, :mood_after)
  end

  def average_mood_after_social_with_alcohol_no_drugs
    calculate_average(social_interactions.select { |interaction| interaction.alcohol_use == true && interaction.drug_use == false }, :mood_after)
  end

  def average_mood_after_social_with_drugs_no_alcohol
    calculate_average(social_interactions.select { |interaction| interaction.alcohol_use == false && interaction.drug_use == true }, :mood_after)
  end

  def average_mood_after_social_with_alcohol_and_drugs
    calculate_average(social_interactions.select { |interaction| interaction.alcohol_use == true && interaction.drug_use == true }, :mood_after)
  end

  def average_mood_after_social_with_no_alcohol_no_drugs
    calculate_average(social_interactions.select { |interaction| interaction.alcohol_use == false && interaction.drug_use == false }, :mood_after)
  end

  def average_stress_before_social_interaction
    calculate_average(social_interactions, :stress_before)
  end

  def average_stress_after_social_interaction
    calculate_average(social_interactions, :stress_after)
  end

  def average_stress_after_social_with_alcohol_no_drugs
    calculate_average(social_interactions.select { |interaction| interaction.alcohol_use == true && interaction.drug_use == false }, :stress_after)
  end

  def average_stress_after_social_with_drugs_no_alcohol
    calculate_average(social_interactions.select { |interaction| interaction.alcohol_use == false && interaction.drug_use == true }, :stress_after)
  end

  def average_stress_after_social_with_alcohol_and_drugs
    calculate_average(social_interactions.select { |interaction| interaction.alcohol_use == true && interaction.drug_use == true }, :stress_after)
  end

  def average_stress_after_social_with_no_alcohol_no_drugs
    calculate_average(social_interactions.select { |interaction| interaction.alcohol_use == false && interaction.drug_use == false }, :stress_after)
  end

  # Helper Methods
  def calculate_average(model_name, attribute)
    values = model_name.map { |model| model.send(attribute) }
    enum_values = values.map { |value| map_enum_to_integer(value) }
    average = enum_values.sum / enum_values.count.to_f
  end

  def map_enum_to_integer(enum)
    if enum == "mb_very_negative" || enum == "ma_very_negative" || enum == "sb_very_stressed" || enum == "sa_very_stressed"
      1
    elsif enum == "mb_moderately_negative" || enum == "ma_moderately_negative" || enum == "sb_moderately_stressed" || enum == "sa_moderately_stressed"
      2
    elsif enum == "mb_slightly_negative" || enum == "ma_slightly_negative" || enum == "sb_slightly_stressed" || enum == "sa_slightly_stressed"
      3
    elsif enum == "mb_neutral" || enum == "ma_neutral" || enum == "sb_moderate" || enum == "sa_moderate"  
      4
    elsif enum == "mb_slightly_positive" || enum == "ma_slightly_positive" || enum == "sb_slightly_relaxed" || enum == "sa_slightly_relaxed"  
      5
    elsif enum == "mb_moderately_positive" || enum == "ma_moderately_positive" || enum == "sb_moderately_relaxed" || enum == "sa_moderately_relaxed"
      6
    elsif enum == "mb_very_positive" || enum == "ma_very_positive" || enum == "sb_very_relaxed" || enum == "sa_very_relaxed"
      7
    else
      raise "Invalid enum value"
    end
  end
end