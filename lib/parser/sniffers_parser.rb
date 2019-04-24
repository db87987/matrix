# frozen_string_literal: true

require_relative '../parser'

# Parses data from sniffers
class SniffersParser < Parser
  NODE_TIMES = 'sniffers/node_times.csv'
  ROUTES = 'sniffers/routes.csv'
  SEQUENCES = 'sniffers/sequences.csv'

  def parse
    node_times.map do |row|
      route_id = route_id_by_node_id(row['node_time_id'])
      time_match = routes.find { |element| element['route_id'] == route_id }
      start_time = time_match['time']
      duration = row['duration_in_milliseconds']
      end_time = time_with_offset(start_time: start_time, duration: duration)

      formatted_row(row['start_node'], row['end_node'], start_time, end_time)
    end
  end

  private

  def route_id_by_node_id(node_time_id)
    route_match = sequences.find do |element|
      element['node_time_id'] == node_time_id
    end
    route_match['route_id']
  end

  def routes
    decode_csv(data[ROUTES])
  end

  def sequences
    decode_csv(data[SEQUENCES])
  end

  def node_times
    decode_csv(data[NODE_TIMES])
  end

  def time_with_offset(start_time:, duration:)
    duration_in_seconds = duration.to_i / 1000
    end_time = Time.parse(start_time) + duration_in_seconds
    formatted_time(end_time)
  end

  def source
    :sniffers
  end
end
