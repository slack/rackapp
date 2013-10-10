include_recipe "god"

template "/etc/god/api-workers.rb" do
  source "god.erb"

  owner "root"
  group "root"
  mode 0644

  variables(
    :group     => "api-workers",
    :name      => "api-worker-1",
    :dir       => "/data/rackapp/current",
    :start_cmd => "bundle exec rake work:some",
    :log       => "/data/rackapp/current/log/api-worker-1.log"
  )
end

execute "reload api-workers config" do
  command <<-SRC
    god stop api-workers
    god remove api-workers
    god load /etc/god/api-workers.rb
  SRC
end
