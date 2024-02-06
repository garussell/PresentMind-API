class TherapistSerializer
  include JSONAPI::Serializer  

  def self.therapist_view(therapist, patients)
    {
      therapist_id: therapist.id,
      therapist_name: therapist.name,
      patients: patients.map do |patient|
        pattern = patient.patterns.first 
        {
          patient_id: patient.id, 
          patient_name: patient.name, 
          patient_pattern: pattern.nil? ? nil : PatternSerializer.create_stats(patient, pattern),
        } 
      end
    }
  end
end
