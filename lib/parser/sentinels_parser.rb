# frozen_string_literal: true

require_relative '../parser'

# Parses data from sentinels
class SentinelsParser < Parser
  ROUTES = 'sentinels/routes.csv'

  def parse
    routes.map do |row|
      start_time = Time.parse(row['time'])
      duration = row['time'][/\+.*/].to_i.minutes
      end_time = start_time + duration

      formatted_row(row['node'], row['node'],
                    formatted_time(start_time), formatted_time(end_time))
    end
  end

  private

  def routes
    decode_csv(data[ROUTES])
  end

  def source
    :sentinels
  end
end
