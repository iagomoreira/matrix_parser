class SentinelsParser < BaseParser
  def initialize(entries)
    @entries = entries
    @last_route_id = nil
    @last_route = nil
    @last_index = nil
    @parsed_routes = []
  end

  def call
    CSV.parse(read_file('routes'), headers: true, col_sep: ", ") do |row|
      if new_route?(row)
        create_new_route(row)
      elsif continuing_route?(row)
        update_last_route(row)
      end
    end

    @parsed_routes.select(&:finished?)
  end

  private

  def invalid_entries?
    @entries.size != 1 && @entries.first.name =~ /^routes/
  end

  def new_route?(row)
    @last_route_id != row['route_id'] || @last_route.nil?
  end

  def continuing_route?(row)
    @last_index == row['index'].to_i-1
  end

  def create_new_route(row)
    @last_route = Route.new(source: 'sentinels', start_node: row['node'], start_time: parse_time(row['time']))
    @last_index = row['index'].to_i
    @last_route_id = row['route_id']
    @parsed_routes << @last_route
  end

  def update_last_route(row)
    current_route = @parsed_routes.last
    current_route.end_node = row['node']
    current_route.end_time = parse_time(row['time'])
    @last_route = Route.new(source: 'sentinels', start_node: row['node'], start_time: parse_time(row['time']))
    @parsed_routes << @last_route
    @last_index = row['index'].to_i
  end
end
