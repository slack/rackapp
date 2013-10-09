#
# Cookbook Name:: main
# Recipe:: default
#

execute "restart-monit" do
  command %Q{ monit quit || [[ $? == 1 ]]}
  action :nothing
end

include_recipe 'god'
