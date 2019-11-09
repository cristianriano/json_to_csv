# frozen_string_literal: true

require 'csv'

# Service to convert an array of hashes into CSV
class ConversorToCSV
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def call
    CSV.generate do |csv|
      items.each do |item|
        write_item(item, csv)
      end
    end
  end

  private

  def write_item(item, csv)
    csv << item.keys
    csv << item.values.map { |i| escape_item(i) }
    csv << []
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
