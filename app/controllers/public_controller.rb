# frozen_string_literal: true

# this is an example of a controller that does not require authentication.  It is not used in this project.  Once I build my controllers each one will require authentication.  I will use this as a template for each controller that does not require authentication.  I will also use this as a template for each controller that does not require a scope.

# class PublicController < ApplicationController
#   def public
#     render json: { message: 'All good. You don\'t need to be authenticated to call this.' }
#   end
# end