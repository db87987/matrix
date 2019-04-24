# frozen_string_literal: true

require 'csv'
require 'active_support/all'

# Base class of sources parsers
class Parser
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  private

  def decode_csv(csv_string)
    csv_string.delete!('"')
    csv = CSV.parse(csv_string, headers: true, col_sep: ', ')
    csv.map(&:to_h)
  end

  def formatted_row(start_node, end_node, start_time, end_time)
    {
      source: source,
      start_node: start_node,
      end_node: end_node,
      start_time: start_time,
      end_time: end_time
    }
  end

  def formatted_time(time)
    time.strftime('%Y-%m-%dT%H:%M:%S')
  end
end
