class RoutesClient
  include HTTParty
  base_uri ENV.fetch('ROUTES_URI')

  class << self
    def loopholes
      get_routes_from_source('loopholes')
    end

    def sentinels
      get_routes_from_source('sentinels')
    end

    def sniffers
      get_routes_from_source('sniffers')
    end

    def push_route(source, start_node, end_node, start_time, end_time)
      body_params = {
        source: source,
        start_node: start_node,
        end_node: end_node,
        start_time: start_time,
        end_time: end_time
      }

      post '/routes', body: secure(body_params)
    end

    private

    def get_routes_from_source(source)
      response = get '/routes', query: secure({source: source})
      unzip response
    end

    def unzip(response)
      Unziper.get_files(StringIO.new(response))
    end

    def secure(params = {})
      secured_params = params.merge(passphrase: ENV.fetch('ROUTES_PASSPHRASE'))
    end
  end
end
