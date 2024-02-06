require 'rails_helper'

RSpec.describe Pattern, type: :model do
  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)

    appointments = create_list(:appointment, 20, patient: @patient)
    exercise_entries = create_list(:exercise_entry, 20, patient: @patient)
    journal_entries = create_list(:journal_entry, 20, patient: @patient)
    medication_entries = create_list(:medication_entry, 20, patient: @patient)
    mindfulness_activities = create_list(:mindfulness_activity, 20, patient: @patient)
    nutrition_entries = create_list(:nutrition_entry, 20, patient: @patient)
    sleep_entries = create_list(:sleep_entry, 20, patient: @patient)
    social_interactions = create_list(:social_interaction, 20, patient: @patient)

    @patterns = Pattern.create(patient: @patient)
  end

  describe "relationships" do
    it { should belong_to(:patient).dependent(:destroy) }
  end

  describe "instance methods" do
    describe "appointments" do
      it "average_mood_before_appointment" do
        moods = Appointment.where(patient: @patient).pluck(:mood_before)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_before_appointment).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_appointment" do
        moods = Appointment.where(patient: @patient).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_appointment).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_before_appointment" do
        stress = Appointment.where(patient: @patient).pluck(:stress_before)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_before_appointment).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_appointment" do
        stress = Appointment.where(patient: @patient).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_appointment).to eq(values.sum / values.count.to_f)
      end
    end

    describe "exercise_entries" do
      it "average_mood_before_exercise" do
        moods = ExerciseEntry.where(patient: @patient).pluck(:mood_before)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_before_exercise).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_exercise" do
        moods = ExerciseEntry.where(patient: @patient).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_exercise).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_before_exercise" do
        stress = ExerciseEntry.where(patient: @patient).pluck(:stress_before)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_before_exercise).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_exercise" do
        stress = ExerciseEntry.where(patient: @patient).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_exercise).to eq(values.sum / values.count.to_f)
      end
    end

    describe "journal_entries" do
      it "average_mood_before_journal" do
        moods = JournalEntry.where(patient: @patient).pluck(:mood_before)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_before_journal).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_journal" do
        moods = JournalEntry.where(patient: @patient).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_journal).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_before_journal" do 
        stress = JournalEntry.where(patient: @patient).pluck(:stress_before)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_before_journal).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_journal" do
        stress = JournalEntry.where(patient: @patient).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_journal).to eq(values.sum / values.count.to_f)
      end
    end

    describe "medication_entries" do
      it "average_mood_before_medication" do
        moods = MedicationEntry.where(patient: @patient).pluck(:mood_before)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_before_medication).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_medication" do
        moods = MedicationEntry.where(patient: @patient).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_medication).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_before_medication" do  
        stress = MedicationEntry.where(patient: @patient).pluck(:stress_before)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_before_medication).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_medication" do
        stress = MedicationEntry.where(patient: @patient).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_medication).to eq(values.sum / values.count.to_f)
      end
    end

    describe "mindfulness_activities" do
      it "average_mood_before_mindfulness_activity" do
        moods = MindfulnessActivity.where(patient: @patient).pluck(:mood_before)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_before_mindfulness_activity).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_mindfulness_activity" do
        moods = MindfulnessActivity.where(patient: @patient).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_mindfulness_activity).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_before_mindfulness_activity" do  
        stress = MindfulnessActivity.where(patient: @patient).pluck(:stress_before)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_before_mindfulness_activity).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_mindfulness_activity" do
        stress = MindfulnessActivity.where(patient: @patient).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_mindfulness_activity).to eq(values.sum / values.count.to_f)
      end
    end

    describe "nutrition_entries" do
      it "average_mood_before_nutrition" do
        moods = NutritionEntry.where(patient: @patient).pluck(:mood_before)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_before_nutrition).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_nutrition" do
        moods = NutritionEntry.where(patient: @patient).pluck(:mood_after) 
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_nutrition).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_incorrect_portion_unhealthy" do
        moods = NutritionEntry.where(patient: @patient, correct_portion: false, healthy: false).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_incorrect_portion_unhealthy).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_incorrect_portion_healthy" do
        moods = NutritionEntry.where(patient: @patient, correct_portion: false, healthy: true).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_incorrect_portion_healthy).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_correct_portion_unhealthy" do
        moods = NutritionEntry.where(patient: @patient, correct_portion: true, healthy: false).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_correct_portion_unhealthy).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_correct_portion_healthy" do
        moods = NutritionEntry.where(patient: @patient, correct_portion: true, healthy: true).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_correct_portion_healthy).to eq(values.sum / values.count.to_f)
      end

      # Stress
      it "average_stress_before_nutrition" do
        stress = NutritionEntry.where(patient: @patient).pluck(:stress_before)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_before_nutrition).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_nutrition" do
        stress = NutritionEntry.where(patient: @patient).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_nutrition).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_incorrect_portion_unhealthy" do
        stress = NutritionEntry.where(patient: @patient, correct_portion: false, healthy: false).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_incorrect_portion_unhealthy).to eq(values.sum / values.count.to_f)
      end
      
      it "average_stress_after_incorrect_portion_healthy" do
        stress = NutritionEntry.where(patient: @patient, correct_portion: false, healthy: true).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_incorrect_portion_healthy).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_correct_portion_unhealthy" do  
        stress = NutritionEntry.where(patient: @patient, correct_portion: true, healthy: false).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_correct_portion_unhealthy).to eq(values.sum / values.count.to_f)
      end
      
      it "average_stress_after_correct_portion_healthy" do
        stress = NutritionEntry.where(patient: @patient, correct_portion: true, healthy: true).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_correct_portion_healthy).to eq(values.sum / values.count.to_f)
      end
    end

    describe "sleep_entries" do
      it "average_mood_before_sleep" do
        moods = SleepEntry.where(patient: @patient).pluck(:mood_before)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_before_sleep).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_sleep" do
        moods = SleepEntry.where(patient: @patient).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_sleep).to eq(values.sum / values.count.to_f)
      end

      it "average_moods_after_dreams" do
        moods = SleepEntry.where(patient: @patient, dream: true).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_moods_after_dreams).to eq(values.sum / values.count.to_f)
      end

      it "average_moods_after_no_dreams" do
        moods = SleepEntry.where(patient: @patient, dream: false).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_moods_after_no_dreams).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_less_than_8_hours" do
        moods = SleepEntry.where(patient: @patient).where("total_hours < ?", 8).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_less_than_8_hours).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_8_hours" do
        moods = SleepEntry.where(patient: @patient).where("total_hours >=?", 8).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_8_hours).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_before_sleep" do
        stress = SleepEntry.where(patient: @patient).pluck(:stress_before)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_before_sleep).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_sleep" do  
        stress = SleepEntry.where(patient: @patient).pluck(:stress_after) 
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_sleep).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_dreams" do
        stress = SleepEntry.where(patient: @patient, dream: true).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_dreams).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_no_dreams" do
        stress = SleepEntry.where(patient: @patient, dream: false).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_no_dreams).to eq(values.sum / values.count.to_f)
      end
    end

    describe "social_interactions" do
      it "average_mood_before_social_interaction" do
        moods = SocialInteraction.where(patient: @patient).pluck(:mood_before)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_before_social_interaction).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_social_interaction" do
        moods = SocialInteraction.where(patient: @patient).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_social_interaction).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_social_with_alcohol_no_drugs" do
        moods = SocialInteraction.where(patient: @patient, alcohol_use: true, drug_use: false).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_social_with_alcohol_no_drugs).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_social_with_drugs_no_alcohol" do
        moods = SocialInteraction.where(patient: @patient, alcohol_use: false, drug_use: true).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_social_with_drugs_no_alcohol).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_social_with_alcohol_and_drugs" do
        moods = SocialInteraction.where(patient: @patient, alcohol_use: true, drug_use: true).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_social_with_alcohol_and_drugs).to eq(values.sum / values.count.to_f)
      end

      it "average_mood_after_social_with_no_alcohol_no_drugs" do
        moods = SocialInteraction.where(patient: @patient, alcohol_use: false, drug_use: false).pluck(:mood_after)
        values = moods.map { |mood| @patterns.map_enum_to_integer(mood) }
        expect(@patterns.average_mood_after_social_with_no_alcohol_no_drugs).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_before_social_interaction" do
        stress = SocialInteraction.where(patient: @patient).pluck(:stress_before)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_before_social_interaction).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_social_interaction" do 
        stress = SocialInteraction.where(patient: @patient).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_social_interaction).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_social_with_alcohol_no_drugs" do
        stress = SocialInteraction.where(patient: @patient, alcohol_use: true, drug_use: false).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_social_with_alcohol_no_drugs).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_social_with_drugs_no_alcohol" do
        stress = SocialInteraction.where(patient: @patient, alcohol_use: false, drug_use: true).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_social_with_drugs_no_alcohol).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_social_with_alcohol_and_drugs" do
        stress = SocialInteraction.where(patient: @patient, alcohol_use: true, drug_use: true).pluck(:stress_after) 
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_social_with_alcohol_and_drugs).to eq(values.sum / values.count.to_f)
      end

      it "average_stress_after_social_with_no_alcohol_no_drugs" do
        stress = SocialInteraction.where(patient: @patient, alcohol_use: false, drug_use: false).pluck(:stress_after)
        values = stress.map { |stress| @patterns.map_enum_to_integer(stress) }
        expect(@patterns.average_stress_after_social_with_no_alcohol_no_drugs).to eq(values.sum / values.count.to_f)
      end
    end
  end
end
