on_app_master do
  # Notify Campfire of deploy with link to diff
  cmd = %{ruby -e "puts 'hello after_restart'" }
  run cmd
end

# tell god to reload processes
on_app_servers do
  sudo 'god signal api-workers QUIT'
end
