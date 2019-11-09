# frozen_string_literal: true

require 'json'

# Validates JSON input
module ConvertHelper
  def items
    json = JSON.parse(request.body.read)

    return json if json.is_a?(Array) && json.all? { |item| item.is_a?(Hash) }

    raise ArgumentError
  end
end
