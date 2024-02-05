class Pattern < ApplicationRecord
  belongs_to :patient, dependent: :destroy
end
