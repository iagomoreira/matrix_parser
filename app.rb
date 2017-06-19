require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

require_relative 'lib/unziper'
require_relative 'lib/routes_client'
