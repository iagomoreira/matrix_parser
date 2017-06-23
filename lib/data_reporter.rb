class DataReporter
  class << self
    def call
      routes = RoutesParser.call
      push_parsed_routes(routes)
    end

    private

    def push_parsed_routes(routes)
      routes.each do |route|
        RoutesClient.push_route(route.source, route.start_node, route.end_node, route.start_time, route.end_time)
      end
    end
  end
end
