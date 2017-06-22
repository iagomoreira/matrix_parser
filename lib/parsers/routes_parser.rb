class RoutesParser
  SOURCES = %i(loopholes sentinels sniffers)

  class << self
    def call
      SOURCES.flat_map do |source|
        routes = get_raw_routes(source)
        get_source_parser(source).call(routes)
      end
    end

    private
    def get_source_parser(source)
      {
        loopholes: LoopholesParser,
        sentinels: SentinelsParser,
        sniffers: SniffersParser
      }.fetch(source)
    end

    def get_raw_routes(source)
      RoutesClient.public_send(source)
    end
  end
end
