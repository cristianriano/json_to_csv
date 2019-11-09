# frozen_string_literal: true

require 'json'

# Validates JSON input
module ApplicationHelper
  def items
    json = JSON.parse(request.body.read)

    return json if json.is_a?(Array) && json.all? { |item| item.is_a?(Hash) }

    raise ArgumentError
  rescue ArgumentError, JSON::ParserError
    content_type 'text/plain'
    halt 400, 'Invalid JSON'
  end
end
