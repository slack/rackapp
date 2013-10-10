require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra/base'

class SinatraApp < Sinatra::Base
  get '/' do
    "Dinky little Sinatra app is up and running, ye salty sea dog!\n"
  end
end

run SinatraApp
