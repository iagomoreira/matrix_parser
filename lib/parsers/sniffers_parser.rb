class SniffersParser
  def self.call(entries)
    new(entries).call
  end

  def initialize(entries)
    @entries = entries
    @parsed_routes = []
    @node_times = []
    @routes = []
    @sequences = []
  end

  def call
    parse_node_times_file
    parse_routes_file
    parse_sequences_file

    create_routes.compact
  end

  private

  def create_routes
    @sequences.map do |sequence|
      route = @routes.find{|r| r['route_id'] == sequence['route_id'] }
      node_time = @node_times.find{|n| n['node_time_id'] == sequence['node_time_id']}

      next if node_time.nil?

      start_time = Time.parse(route['time']+route['time_zone'])
      end_time = start_time + node_time['duration_in_milliseconds'].to_i

      Route.new(
        source: 'sniffers',
        start_node: node_time['start_node'],
        end_node: node_time['end_node'],
        start_time: start_time,
        end_time: end_time
      )
    end
  end

  def parse_node_times_file
    parse_file('node_times', @node_times)
  end

  def parse_routes_file
    parse_file('routes', @routes)
  end

  def parse_sequences_file
    parse_file('sequences', @sequences)
  end

  def parse_file(file_name, collection)
    file = @entries.find{|e| e.name =~ /#{file_name}/ }.get_input_stream.read

    CSV.parse(file, headers: true, col_sep: ", " ) do |row|
      collection.push(row)
    end
  end
end
