# frozen_string_literal: true

require 'app/controllers/application_controller'
require 'csv'

# Converts JSON payload into CSV
class ConvertController < ApplicationController
  before do
    content_type 'text/csv'
  end

  post '/' do
    CSV.generate do |csv|
      items.each do |item|
        csv << item.keys
        csv << item.values
        csv << []
      end
    end
  end
end
