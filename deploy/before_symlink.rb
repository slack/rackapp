ObjectSpace.each_object(IO) do |io|
  puts io.inspect
  next if [STDIN, STDOUT, STDERR].include?(io)
  unless io.closed?
    begin
      puts "closing #{io.inspect}"
      io.close
    rescue ::Exception => e
      puts "caught exception on (#{io.inspect}): #{e.message}"
    end
  end
end
