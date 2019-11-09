# frozen_string_literal: true

require 'app/controllers/application_controller'
require 'app/helpers/convert_helper'
require 'app/services/conversor_to_csv'

# Converts JSON payload into CSV
class ConvertController < ApplicationController
  helpers ConvertHelper

  before do
    content_type 'text/csv'
  end

  post '/' do
    ConversorToCSV.new(items).call
  rescue ArgumentError, JSON::ParserError
    content_type 'text/plain'
    halt 400, 'Invalid JSON'
  end
end
