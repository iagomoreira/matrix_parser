class LoopholesParser
  def self.call(entries)
    new(entries).call
  end

  def initialize(entries)
    @entries = entries
    @node_pairs = []
    @routes = []
  end

  def call
    parse_node_pairs_file
    parse_routes_file

    create_routes.compact
  end

  def create_routes
    @routes.map do |route|
      node_pair = @node_pairs.find{|n| n['id'] == route['node_pair_id'] }

      next if node_pair.nil?

      Route.new(
        source: 'loopholes',
        start_node: node_pair['start_node'],
        end_node: node_pair['end_node'],
        start_time: route['start_time'],
        end_time: route['end_time']
      )
    end
  end

  private

  def parse_node_pairs_file
    @node_pairs = parse_file('node_pairs')
  end

  def parse_routes_file
    @routes = parse_file('routes')
  end

  def parse_file(file_name)
    file = @entries.find{|e| e.name =~ /#{file_name}/ }.get_input_stream.read
    JSON.parse(file)[file_name]
  end
end
