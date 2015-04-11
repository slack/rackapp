require "rubygems"
require "bundler"
Bundler.setup

require "sinatra/base"
require "sys/proctable"

class SinatraApp < Sinatra::Base
  include Sys

  before do
    content_type "text/plain"
  end

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

  get "/pokey" do
    nap = 1.0 / rand(2..30).to_f
    sleep nap
    "OK, slept #{nap}s\n"
  end

  get "/check/dump" do
    process = ProcTable.ps($$)
    output = <<-OUTPUT
NOW   = #{Time.now}
COMM  = #{process.comm}
CWD   = #{Dir.pwd}
PID   = #{process.pid}
PPID  = #{process.ppid}
START = #{process.starttime}
SHA   = #{%x(git rev-parse HEAD)}
    OUTPUT

    puts output
  end
end


run SinatraApp
