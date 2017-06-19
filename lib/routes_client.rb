class RoutesClient
  include HTTParty
  base_uri ENV.fetch('ROUTES_URI')

  class << self
    def get_routes_from_source(source)
      response = get '/routes', secure(source: source)
      unzip response
    end

    private

    def unzip(response)
      Unziper.get_files(StringIO.new(response))
    end

    def secure(params = {})
      secured_params = params.merge(passphrase: ENV.fetch('ROUTES_PASSPHRASE'))
      {query: secured_params}
    end
  end
end
