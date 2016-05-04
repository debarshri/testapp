require './app/initializer'

if ARGV[0] == 'initial_run'
  Initializer.init
elsif ARGV[0] == 'server_only'
  Initializer.run
else
  Initializer.init
  Initializer.run
end

