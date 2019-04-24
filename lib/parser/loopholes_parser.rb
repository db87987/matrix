# frozen_string_literal: true

require_relative '../parser'

# Parses data from loopholes
class LoopholesParser < Parser
  NODE_PAIRS = 'loopholes/node_pairs.json'
  ROUTES = 'loopholes/routes.json'

  def parse
    node_pairs.map do |row|
      route = routes.find { |element| element['node_pair_id'] == row['id'] }

      formatted_row(row['start_node'], row['end_node'],
                    route['start_time'].chop!, route['end_time'].chop!)
    end
  end

  private

  def node_pairs
    JSON.parse(data[NODE_PAIRS]).values.flatten!
  end

  def routes
    @routes ||= JSON.parse(data[ROUTES]).values.flatten!
  end

  def source
    :loopholes
  end
end
