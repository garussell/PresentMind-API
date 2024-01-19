# frozen_string_literal: true

# this is an example of a controller that requires authentication.  It is not used in this project.  Once I build my controllers each one will require authentication.  I will use this as a template for each controller that requires authentication.  I will also use this as a template for each controller that requires a scope.


# class PrivateController < ApplicationController
  # before_action :authorize -- i placed this in the application controller so that it will be inherited by all controllers that require authentication

#   def private
#     render json: { message: 'Hello from a private endpoint! You need to be authenticated to see this.' }
#   end

#   def private_scoped
#     validate_permissions ['read:messages'] do
#       render json: { message: 'Hello from a private endpoint! You need to be authenticated and have a scope of read:messages to see this.' }
#     end
#   end
# end