worker_pool 5
queue "low", :percent => 20
queue "normal", :percent => 60
queue "*"

after_fork do |worker|
  worker.term_timeout = 60 * 60 * 24 # day
end
