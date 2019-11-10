# frozen_string_literal: true

require 'csv'

# Lazily converts an array of JSON objects into CSV lines
class ConversorToCSV
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def call
    return enum_for(:call) unless block_given?

    items.each do |item|
      yield write_item(item)
    end
  end

  private

  def write_item(item)
    values = item.values.map { |i| escape_item(i) }
    CSV.generate_line(item.keys) + CSV.generate_line(values) + "\n"
  end

  def escape_item(item)
    case item
    when Array, Hash
      JSON.dump(item)
    else
      item
    end
  end
end
