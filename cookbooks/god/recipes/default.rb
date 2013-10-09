execute "restart god" do
  command <<-SRC
    if pgrep god; then
      for try in 1 2 3 4 5; do
        god quit && exit 0
        sleep 1
      done
      exit 1
    fi
  SRC
  action :nothing
end

gem_package "god" do
  gem_binary "/usr/bin/gem"
  version "0.13.3"
  action :install
  notifies :run, resources(:execute => "restart god")
end

# stable-v2 and stable-v4 have different gem bin paths
god_path = if File.exists?("/usr/bin/god")
             "/usr/bin/god"
           else
             "/usr/local/bin/god"
           end

directory "/etc/god" do
  owner "root"
  group "root"
  mode 0755
  recursive true
end

template "/etc/god/config" do
  owner "root"
  group "root"
  mode 0644
  source "config.erb"
end

execute "telinit q" do
  command "telinit q"
  action :nothing
end

template "/tmp/god-inittab" do
  source "inittab.erb"
  owner "root"
  group "root"
  mode 0644
  variables(:god_path => god_path)
end

execute "make init work with god" do
  command "cat /tmp/god-inittab >>/etc/inittab"
  not_if "grep '# god config' /etc/inittab"
  notifies :run, resources(:execute => "telinit q"), :immediate
end

file "/tmp/god-inittab" do
  action :delete
end

template "/etc/logrotate.d/god" do
  source "logrotate.erb"
  owner "root"
  group "root"
  mode 0644
end
