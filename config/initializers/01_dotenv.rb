# frozen_string_literal: true
if Rails.env.development? || Rails.env.test?
  require 'dotenv'
  Dotenv.load
end