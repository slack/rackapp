require "rubygems"
require "bundler"
Bundler.setup

require "sinatra/base"
require "sys/proctable"

class SinatraApp < Sinatra::Base
  include Sys

  get "/" do
    "Dinky little Sinatra app is up and running, ye salty sea dog!\n"
  end

  get "/health" do
    "OK\n"
  end

  get "/flaky" do
    if (rand(100) % 3) == 0
      "OK\n"
    else status 500
    end
  end

  get "/check/dump" do
    process = ProcTable.ps($$)
    output = <<-OUTPUT
NOW   = #{Time.now}
COMM  = #{process.comm}
CWD   = #{Dir.pwd}
START = #{process.starttime}
SHA   = #{%x(git rev-parse HEAD)}
    OUTPUT
  end
end


run SinatraApp
