require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra/base'

class SinatraApp < Sinatra::Base
  get '/' do
    "Dinky little Sinatra app is up and running, ye salty sea dog!\n"
  end

  get '/health' do
    "OK\n"
  end

  get '/flaky' do
    if (rand(100) % 3) == 0
      "OK\n"
    else status 500
    end
  end
end

run SinatraApp
