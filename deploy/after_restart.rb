on_app_master do
  # Notify Campfire of deploy with link to diff
  cmd = %{ruby -e "puts 'hello after_restart'" }
  run cmd
end
