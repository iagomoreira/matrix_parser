require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

require_relative 'lib/models/route'

require_relative 'lib/unziper'
require_relative 'lib/routes_client'

require_relative 'lib/parsers/base_parser'
require_relative 'lib/parsers/loopholes_parser'
require_relative 'lib/parsers/sentinels_parser'
require_relative 'lib/parsers/sniffers_parser'
require_relative 'lib/parsers/routes_parser'
