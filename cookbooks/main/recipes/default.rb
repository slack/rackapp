# default cookbook

# only run on app boxes
if ["app_master", "app", "solo"].include?(node[:instance_role])
  require_recipe "myapp"
end
