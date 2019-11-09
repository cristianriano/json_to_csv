# frozen_string_literal: true

require 'app/controllers/application_controller'

# Checks the app is up and running
class CheckController < ApplicationController
  get '/' do
    'OK'
  end
end
